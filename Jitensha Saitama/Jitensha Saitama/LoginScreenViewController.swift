//
//  LoginScreenViewController.swift
//  Jitensha Saitama
//
//  Created by Mohammad Zulqurnain on 15/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

import UIKit

/**
 # LoginScreenViewController # 
 Class for handling the user login and registration
 */

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var userNameTextfield: UITextFieldRoundedCorner!
    
    @IBOutlet weak var passwordTextfield: UITextFieldRoundedCorner!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var rememberMeButton: UIButton!
  
    var isRememberMeSelected = Bool(false)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //check saved states
        if let userNameValue:String = UserDefaults.standard.object(forKey: "userName") as? String{
            userNameTextfield.text = userNameValue
        }
        
        if let password:String = UserDefaults.standard.object(forKey: "password") as? String{
            passwordTextfield.text = password
        }
        
        if let selected:Bool  = UserDefaults.standard.object(forKey: "selected") as? Bool{
        isRememberMeSelected = selected
            //load
            if isRememberMeSelected{
            
                rememberMeButton.titleLabel?.textColor = UIColor.red
            }else{
                
             rememberMeButton.titleLabel?.textColor = UIColor.black
            }
        }
       
    }

    func viewWillDisappear(){
    
        if(isRememberMeSelected){
            rememberMeButton.setImage(UIImage(named:"rememberMe"), for: .normal)
            UserDefaults.standard.set(userNameTextfield.text, forKey: "userName")
            UserDefaults.standard.set(passwordTextfield.text, forKey: "password")
            UserDefaults.standard.synchronize()
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    /**
     # loginButtonAction #
     Handle user login and map segue
     */
    @IBAction func loginButtonAction(_ sender: Any) {
        
        print("\(userNameTextfield.text!)")
        
        if isValidEmail(testStr: userNameTextfield.text!){
            
            CommonFunctionality.sharedCommonFunctionality.doWebRequest(urlString: "\(backendUrl)api/v2.0/users/", requestType:"POST", paraDictionay: ["email":userNameTextfield.text!, "password":passwordTextfield.text!], failureCallback: failureCallback, callback:  { (responseString: NSDictionary) -> Void in
     
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                
                DispatchQueue.main.async {
                    
                if let userToken:String  = appDelegate.userToken{
                    
                    if userToken == appDelegate.userToken{
                    
                    let alert = UIAlertController(title: "Alert", message: "User Successfully Logged in", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(void) in
                            
                            DispatchQueue.main.async {
                                
                            self.performSegue(withIdentifier: "segueToMapViewController", sender: self)
                            
                            }
                            
                            }))
                    
                    self.present(alert, animated: false, completion: nil)
                        
                    }
                    
                }
                
                if let message:String = responseString.value(forKey: "message") as! String!{

                        if message == "InternalServerError"{
                        
                            let alert = UIAlertController(title: "Alert", message: "Please Enter Correct User Name And Password", preferredStyle: UIAlertControllerStyle.alert)
                            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                            
                        }

                    
                }
                    
                }
            })
        }
    }

    
    /**
     # loginButtonAction #
     Handle user registration
     */
    @IBAction func signupButtonAction(_ sender: Any) {
        
        if isValidEmail(testStr: userNameTextfield.text!){
            
            CommonFunctionality.sharedCommonFunctionality.doWebRequest(urlString: "\(backendUrl)api/v2.0/users/", requestType:"PUT", paraDictionay: ["email":userNameTextfield.text!, "password":passwordTextfield.text!], failureCallback: failureCallback, callback:  {  (responseString: NSDictionary) -> Void in
                
                print("responseString : \(responseString)")
               
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                DispatchQueue.main.async {
                    
                    if let userToken:String  = responseString.value(forKey: "token") as? String{
                
                    appDelegate.userToken = userToken
                    
                    UserDefaults.standard.set(appDelegate.userToken!, forKey: "token")
                    
                    let alert = UIAlertController(title: "Alert", message: "User Successfully Registered", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    
                    self.present(alert, animated: false, completion: nil)
                    
                }
                
                
                if let message:String = responseString.value(forKey: "message") as? String{

                        
                        if message == "EmailAlreadyTaken"{
                            
                        let alert = UIAlertController(title: "Alert", message: "Email Already Taken", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                        
                        self.present(alert, animated: false, completion: nil)
                            
                        }

                    
                }
                    
                }
            })
        }
        
    }

    /**
     # save state of he fields#
     */
    @IBAction func rememberMeButtonAction(_ sender: Any) {
        let button:UIButton = sender as! UIButton
        
        isRememberMeSelected =  !isRememberMeSelected

        UserDefaults.standard.set(isRememberMeSelected, forKey: "selected")
        
        if(isRememberMeSelected){
        
         button.titleLabel?.textColor = UIColor.red
            
        UserDefaults.standard.set(userNameTextfield.text, forKey: "userName")
        UserDefaults.standard.set(passwordTextfield.text, forKey: "password")
        UserDefaults.standard.synchronize()
            
        }else{
            
            button.titleLabel?.textColor = UIColor.black
           
            UserDefaults.standard.set(isRememberMeSelected, forKey: "selected")
            
        }

        

    }
    
    
    @IBAction func forgetPasswordButtonAction(_ sender: Any) {
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

extension UIViewController{
    
    /**
     # failure callback #
     */
    func failureCallback()  {
        
        let alert = UIAlertController(title: "Alert", message: "Please make sure that network connection is working smoothly", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: false, completion: nil)
    }
    
    
    /**
     # Check email validity #
     */
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /**
     # Check credit card validity #
     */
    func isValidCreditCardNumber(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let forwardSlash: Character = "\u{005C}"
        let emailRegEx =  "\(forwardSlash)^(?:4[0-9]{12}(?:[0-9]{3})?|[25][1-7][0-9]{14}|6(?:011|5[0-9][0-9])[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|(?:2131|1800|35\(forwardSlash)d{3})\(forwardSlash)d{11})$"
        
        let cardNumberTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return cardNumberTest.evaluate(with: testStr)
    }
}
