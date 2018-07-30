//
//  PaymentStruct.swift
//  Jitensha Saitama
//
//  Created by Mohammad Zulqurnain on 16/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

import UIKit

/**
 # PaymentStruct #
 Struct for storing the json payment  elements which will populate table for payment
 */
struct PaymentStruct{
    
    var number: String!
    var name: String!
    var date: String!
    var placeID: String!
    
    init()
    {
         number = " "
         name = " "
         date = " "
         placeID = " "
    }
    
    init(  pNumber: String!, pName: String!, pDate: String!, pPlaceID: String!)
    {
        if let pNumberValue:String = pNumber{
            number = pNumberValue
        }
        
        if let pNameValue:String = pName{
            name = pNameValue
        }
        
        if let pDateValue:String = pDate{
            date = pDateValue
        }
        
        if let pPlaceIDValue:String = pPlaceID{
            placeID = pPlaceIDValue
        }
        
    }
    
}
