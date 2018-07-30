//
//  CardValidator.swift
//  Jitensha Saitama
//
//  Created by Mohammad Zulqurnain on 16/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

import UIKit

//: Playground - noun: a place where people can play
//http://stackoverflow.com/questions/72768/how-do-you-detect-credit-card-type-based-on-number
import UIKit
import Foundation

enum CreditCardType {
    
    case visa
    case visaElectron
    case mastercard
    case maestro
    case americanExpress
    case dinnersClub
    case discovery
    case jcb
    
    static var all: [CreditCardType] {
        return [
            .visa,
            .visaElectron,
            .mastercard,
            .maestro,
            .americanExpress,
            .dinnersClub,
            .discovery,
            .jcb
        ]
    }
    
    var pattern: String {
        switch self {
        case .visa: return "^4[0-9]{12}(?:[0-9]{3})?$"
        case .visaElectron: return "^(4026|417500|4508|4844|491(3|7))"
        case .mastercard: return "^5[1-5][0-9]{14}$"
        case .maestro: return "^(5018|5020|5038|6304|6759|676[1-3])"
        case .americanExpress: return "^3[47][0-9]{13}$"
        case .dinnersClub: return "^3(?:0[0-5]|[68][0-9])[0-9]{11}$"
        case .discovery: return "^6(?:011|5[0-9]{2})[0-9]{12}$"
        case .jcb: return "^(?:2131|1800|35\\d{3})\\d{11}$"
        }
    }
    
    var exampleValue: String {
        switch self {
        case .visa: return "4111111111111111"
        case .visaElectron: return "4026000000000002"
        case .mastercard: return "5538383883833838"
        case .maestro: return "501800000009"
        case .americanExpress: return "347000000000000"
        case .dinnersClub: return "30099999999999"
        case .discovery: return "6550000000000000"
        case .jcb: return "180000000000000"
        }
    }
}

struct Validator {
    let cardType: CreditCardType
    let value: String
    
    func test() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: self.cardType.pattern,
                                                options: .caseInsensitive)
            return regex.matches(in: value,
                                 options: [],
                                 range: NSMakeRange(0, value.characters.count)).count > 0
        } catch {
            return false
        }
        
    }
}
