//
//  Jitensha_SaitamaTests.swift
//  Jitensha SaitamaTests
//
//  Created by Mohammad Zulqurnain on 15/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

import XCTest
@testable import Jitensha_Saitama

class Jitensha_SaitamaTests: XCTestCase {
    
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//        continueAfterFailure = false
//        //UI test for the application which will in turn execute for every test method
//        //XCUIApplication().launch()
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//
//    func UITest(){
//    
//    let app = XCUIApplication()
//        
//        app.buttons["Login"].tap()
//        
//        
//        app.buttons["Register"].tap()
//        
//        
//        app.maps["mapView"].swipeRight()
//        
//        //app.maps["mapView"].otherElements["annotations"]
//    }
//    
//    //Check user registration api
//    func testIsApiForUserRegistrationWorking() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//
//        CommonFunctionality.sharedCommonFunctionality.doWebRequest(urlString: "\(backendUrl)v2.0/users/", requestType:"PUT", paraDictionay: ["email":"mohammad.zulqurnain@gmail.com", "password":"paramount"], failureCallback: {
//            
//            print("Failure")
//            }
//            , callback:  {  (responseString: NSDictionary) -> Void in
//            
//            print("responseString : \(responseString)")
//            XCTAssertNil(responseString)
//                
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            
//            DispatchQueue.main.async {
//                
//                if let userToken  = responseString.value(forKey: "token"){
//                    
//                    appDelegate.userToken = userToken as! String
//                    
//                    UserDefaults.standard.set(appDelegate.userToken, forKey: "token")
//                    
//                    print("registered successfully")
//                    
//                }
//                
//                
//                if let message:String = responseString.value(forKey: "message") as? String{
//                    
//                    
//                    if message == "EmailAlreadyTaken"{
//                        
//                        
//                        print("Email already successfully")
//                        
//                        
//                    }
//                    
//                    
//                }
//                
//            }
//        })
//
//    }
//    
//    //Check user authentication api
//    func testIsApiForUserAuthenticationWorking() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        
//        CommonFunctionality.sharedCommonFunctionality.doWebRequest(urlString: "\(backendUrl)v2.0/users/", requestType:"POST", paraDictionay: ["email":"mohammad.zulqurnain@gmail.com", "password":"paramount"], failureCallback: {
//            
//            print("Failure")
//        }
//            , callback:  {  (responseString: NSDictionary) -> Void in
//                
//                print("responseString : \(responseString)")
//                XCTAssertNil(responseString)
//                
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                
//                DispatchQueue.main.async {
//                    
//                    if let userToken  = responseString.value(forKey: "token"){
//                        
//                        appDelegate.userToken = userToken as! String
//                        
//                        UserDefaults.standard.set(appDelegate.userToken, forKey: "token")
//                        
//                        print("registered successfully")
//                        
//                    }
//                    
//                    
//                    if let message:String = responseString.value(forKey: "message") as? String{
//                        
//                        
//                        if message == "EmailAlreadyTaken"{
//                            
//                            
//                            print("Email already successfully")
//                            
//                            
//                        }
//                        
//                        
//                    }
//                    
//                }
//        })
//        
//    }
//    
//    //Check locations api
//    func testIsApiForUserAnnotationWorking() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        
//        //clear the annotations array
//        CommonFunctionality.sharedCommonFunctionality.locationAnnotationDataArray.removeAll()
//        
//        //fetch annotations array data from json
//        CommonFunctionality.sharedCommonFunctionality.doWebRequest(urlString: "\(backendUrl)v2.0/places", requestType:"GET", paraDictionay: [:], failureCallback:  {
//            
//            print("Failure")
//        }, callback:  { (responseString: NSDictionary) -> Void in
//            
//            // print("responseString : \(responseString)")
//            
//            let jsonArray = responseString as NSDictionary
//            let object = jsonArray.value(forKey: "places")  as! [AnyObject]
//            
//            for element in object{
//                
//                if let lat:Double = Double(((element["location"] as? Dictionary<String, String>)?["lat"])!), let lng:Double = Double(((element["location"] as? Dictionary<String, String>)?["lng"])!){
//                    // if let lat:Double = Double(latString) , let lng:Double = Double(lngString){
//                    
//                    print("element : \(element)")
//                    
//                    CommonFunctionality.sharedCommonFunctionality.locationAnnotationDataArray.append(LocationStruct(pId: element["id"] as? String, pName: element["name"] as? String, pLat:lat, pLng:lng))
//                    // }
//                }
//                
//            }
//        })
//    }
//


}
