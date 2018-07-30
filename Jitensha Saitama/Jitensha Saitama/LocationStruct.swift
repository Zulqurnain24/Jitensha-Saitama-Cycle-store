//
//  LocationStruct.swift
//  Jitensha Saitama
//
//  Created by Mohammad Zulqurnain on 15/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

import UIKit

/**
 # LocationStruct #
 Struct for storing the json bike store elements which will populate map
 */
struct LocationStruct{

    var id: String!
    var name: String!
    var lat: Double!
    var lng: Double!
    
    init()
    {
         id = String("")
         name = String("")
         lat = 0.0
         lng = 0.0
    }
    
    init(  pId: String!, pName: String!, pLat: Double!, pLng: Double!)
    {
        if let pIdValue:String = pId{
        id = pIdValue
        }
        if let pNameValue:String = pName{
            name = pNameValue
        }
        if let pLatValue:Double = pLat{
            lat = pLatValue
        }
        if let pLngValue:Double = pLng{
            lng = pLngValue
        }

    }
    
}
