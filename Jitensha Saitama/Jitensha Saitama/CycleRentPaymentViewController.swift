//
//  CycleRentPaymentViewController.swift
//  Jitensha Saitama
//
//  Created by Mohammad Zulqurnain on 16/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

import UIKit

class CycleRentPaymentViewController: UIViewController, UITextFieldDelegate, AKPickerViewDataSource, AKPickerViewDelegate {

    @IBOutlet weak var viewForBlur: UIView!
    
    @IBOutlet weak var textfieldName: UITextFieldRoundedCorner!
    
    @IBOutlet weak var textfieldCreditCard: UITextFieldRoundedCorner!
    
    @IBOutlet weak var textfieldCvv: UITextFieldRoundedCorner!
    
    
    @IBOutlet weak var textfieldExpiryMonth: UITextFieldRoundedCorner!
    
    @IBOutlet weak var textFieldExpiryYear: UITextFieldRoundedCorner!

    var paymentStruct : PaymentStruct!
    
    var expiryDatePicker : MonthYearPickerView!
    
    var pickerViewForCardSelect: AKPickerView!
    
    let titles = [ "visa","visaElectron","mastercard","maestro", "americanExpress","dinnersClub", "discovery","jcb"]

    var cardType : CreditCardType!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textfieldName.delegate = self
        
        textfieldCreditCard.delegate = self
        
        textfieldCvv.delegate = self

        textfieldExpiryMonth.delegate = self
        
        textFieldExpiryYear.delegate = self
        
        textfieldCreditCard.tag = 2
        
        textfieldCvv.tag = 3
        
        expiryDatePicker = MonthYearPickerView(frame: .zero)

        pickerViewForCardSelect = AKPickerView(frame: textfieldCreditCard.frame)
        
        self.pickerViewForCardSelect.delegate = self
        self.pickerViewForCardSelect.dataSource = self
        
        self.pickerViewForCardSelect.font = UIFont(name: "HelveticaNeue-Light", size: 20)!
        self.pickerViewForCardSelect.highlightedFont = UIFont(name: "HelveticaNeue", size: 20)!
        self.pickerViewForCardSelect.pickerViewStyle = .wheel
        self.pickerViewForCardSelect.maskDisabled = false
        self.pickerViewForCardSelect.reloadData()
        
        textfieldCreditCard.inputView = pickerViewForCardSelect
        
        textfieldExpiryMonth.inputView = expiryDatePicker
        
        textFieldExpiryYear.inputView = expiryDatePicker
        // Do any additional setup after loading the view.
        //only apply the blur if the user hasn't disabled transparency effects
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            //self.view.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.viewForBlur.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            self.viewForBlur.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        }
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField.tag == 2 || textField.tag == 3{
            
            // Create an `NSCharacterSet` set which includes everything *but* the digits
            let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
            
            // At every character in this "inverseSet" contained in the string,
            // split the string up into components which exclude the characters
            // in this inverse set
            let components = string.components(separatedBy: inverseSet)
            
            // Rejoin these components
            let filtered = components.joined(separator: "")  // use join("", components) if you are using Swift 1.2
            
            // If the original string is equal to the filtered string, i.e. if no
            // inverse characters were present to be eliminated, the input is valid
            // and the statement returns true; else it returns false
            print("string == filtered")
            return ((textField.text?.characters.count)! >= 0)  && (string == filtered)
        }/*else if textField.tag == 2{
            
            
            return ((textField.text?.characters.count)! >= 0) && ((textField.text?.characters.count)! <= CreditCardType.all[pickerViewForCardSelect.selectedItem].exampleValue.characters.count)
            
        }*/else{
            print("not cvv")
            return true
        }
    }
    
    // MARK: - AKPickerViewDataSource
    
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return self.titles.count
    }
    
    /*
     
     Image Support
     -------------
     Please comment '-pickerView:titleForItem:' entirely and
     uncomment '-pickerView:imageForItem:' to see how it works.
     
     */
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return self.titles[item]
    }
    
    func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: self.titles[item])!
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        print("Your favorite city is \(self.titles[item])")
    }

    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
       
        textfieldExpiryMonth.text = "\(expiryDatePicker.month)"
        
        textFieldExpiryYear.text = "\(expiryDatePicker.year)"
    }
    
    override func touchesBegan(_ touches: Set<
        UITouch>, with event: UIEvent?) {
        
        print("tapped!")
        
        var month : String
        
        if (expiryDatePicker.month ) < 10{
            
            month = "0\(expiryDatePicker.month)"
        }else{
            
            month = "\(expiryDatePicker.month)"
            
        }
        
        textfieldExpiryMonth.text = "\(month)"
        
        textFieldExpiryYear.text = "\(expiryDatePicker.year)"

        textfieldCreditCard.placeholder = "Sample->\(CreditCardType.all[pickerViewForCardSelect.selectedItem].exampleValue)"
     
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    
    
    @IBAction func buttonPerformPaymentAction(_ sender: Any) {

        if Validator(cardType: CreditCardType.all[pickerViewForCardSelect.selectedItem], value: textfieldCreditCard.text!).test(){

            
            CommonFunctionality.sharedCommonFunctionality.doWebRequest(urlString: "http://localhost:3000/api/v2.0/payments/", requestType:"PUT", paraDictionay: ["placeId":paymentStruct.placeID!, "number":textfieldCreditCard.text!, "cvv":textfieldCvv.text!, "expiryMonth":"\(textfieldExpiryMonth.text!)", "expiryYear":textFieldExpiryYear.text!, "name":textfieldName.text!], failureCallback: failureCallback, callback:  { (responseString: NSDictionary) -> Void in
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                
                DispatchQueue.main.async {
                    print("responseString: \(responseString)")
      
                    if (responseString.value(forKey: "message") as! String) == "PaymentSuccess"{
                        
                        let alert = UIAlertController(title: "Alert", message: "Payment Done Successfully Made", preferredStyle: UIAlertControllerStyle.alert)
                                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: false, completion: nil)
                      
                    }else if (responseString.value(forKey: "message") as! String) == "InvalidCreditCard"{
                    
                        
                        let alert = UIAlertController(title: "Alert", message: "Invalid Card Credentials Detected Please Enter Authentic Credentials", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: false, completion: nil)
                    }else if (responseString.value(forKey: "message") as! String) == "Unauthorized"{
                        
                        
                        let alert = UIAlertController(title: "Alert", message: "Token mismatch Detected Please Relogin", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: false, completion: nil)
                    }
//
                    
                }
            })
        }else{
        
                let alert = UIAlertController(title: "Alert", message: "Please enter correct format for \(titles[pickerViewForCardSelect.selectedItem]) card", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            
                self.present(alert, animated: false, completion: nil)
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
