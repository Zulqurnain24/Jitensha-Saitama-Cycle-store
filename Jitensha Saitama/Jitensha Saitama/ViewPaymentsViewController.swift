//
//  ViewPaymentsViewController.swift
//  Jitensha Saitama
//
//  Created by Mohammad Zulqurnain on 16/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

import UIKit

class ViewPaymentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var tableForPayment: UITableView!
    
    var cellReuseIdentifier = "PaymentTableviewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableForPayment.delegate = self
        
        tableForPayment.dataSource = self
        
        
        CommonFunctionality.sharedCommonFunctionality.doWebRequest(urlString: "\(backendUrl)api/v2.0/payments/", requestType:"GET", paraDictionay: [:], failureCallback: failureCallback, callback:  { (responseString: NSDictionary) -> Void in
        
           // DispatchQueue.main.async {
                
                let jsonArray = responseString as NSDictionary
                print("responseString: \(responseString)")
            //only pursue further if the dictionary object is not nil
            if let object:[AnyObject] = jsonArray.value(forKey: "payments") as? [AnyObject] {
                
                print("I am inside!")
                
                for element in object{
                    
                    CommonFunctionality.sharedCommonFunctionality.paymentDataArray.append(PaymentStruct(pNumber: (element["creditCard"] as? Dictionary<String, String>)?["number"], pName: (element["creditCard"] as? Dictionary<String, String>)?["name"], pDate: (element["updatedAt"] as? String), pPlaceID:  jsonArray.value(forKey: "placeId") as? String))
                }
                
                DispatchQueue.main.async {
                    
                    self.tableForPayment.reloadData()
                }
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  CommonFunctionality.sharedCommonFunctionality.paymentDataArray.count

    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! PaymentTableviewCell
        
        cell.labelName.text = CommonFunctionality.sharedCommonFunctionality.paymentDataArray[indexPath.row].name
        
        cell.labelCardNumber.text = CommonFunctionality.sharedCommonFunctionality.paymentDataArray[indexPath.row].number
        
        cell.labelDateCreated.text = CommonFunctionality.sharedCommonFunctionality.paymentDataArray[indexPath.row].date
        
        return cell

    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print("You tapped cell number \(indexPath.row).")
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
