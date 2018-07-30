//
//  CommonFunctionality.swift
//  Jitensha Saitama
//
//  Created by Mohammad Zulqurnain on 15/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

// MARK: - Singleton

import UIKit
import Foundation

/**
 # CommonFunctionality #
 Class for certain api calls
 */
final class CommonFunctionality {
    
    // Can't init is singleton
    private init() { }
    
    //Callback
    var failureCallback = (((Void) -> Void)).self
    
    // MARK: Shared Instance
    
    static let sharedCommonFunctionality = CommonFunctionality()
    
    // MARK: location collection array
    
    var locationAnnotationDataArray : [LocationStruct] = []
    
    // MARK: payment collection array
    
    var paymentDataArray : [PaymentStruct] = []
    
    
    func doWebRequest(urlString:String, requestType:String, paraDictionay: [String: String], failureCallback:@escaping ((Void) -> Void), callback:@escaping ((NSDictionary) -> Void)){
        
        //Check for active internet connection
        if IJReachability.isConnectedToNetwork() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var request = URLRequest(url: URL(string: urlString)!)

        request.httpMethod = requestType
        print("userToken -> \(appDelegate.userToken!)")
            
        let accessToken = appDelegate.userToken!
        
        if urlString.range(of:"payments") != nil && (requestType == "PUT" || requestType == "GET"){
            
            request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
          
        }
  
        if requestType == "GET"{
            
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }
            
        if requestType == "POST" || requestType == "PUT"{
       
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
            
        let jsonParameters = paraDictionay
        let jsonData = try!JSONSerialization.data(withJSONObject: jsonParameters, options:.prettyPrinted)
        
        request.httpBody = jsonData

            
        }

            let task = URLSession.shared.dataTask(with: request) { data, response, error in

                guard let data = data, error == nil else {                                                 // check for fundamental networking error
                    print("-> error = \(String(describing: error))")
                    
//                    DispatchQueue.main.async {
//                        
//                        failureCallback()
//                        
//                    }
                    
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing:  response))")
                    
                }
                
                if let jsonResult: NSDictionary = try!JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                {
                    //print("json data = \(jsonResult)")
                    callback(jsonResult)

                }

            }
            task.resume()
         
        }
    }
    
    
   
}
