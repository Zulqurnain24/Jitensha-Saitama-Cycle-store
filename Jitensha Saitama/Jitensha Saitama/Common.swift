//
//  Common.swift
//  Jitensha Saitama
//
//  Created by Mohammad Zulqurnain on 15/07/2017.
//  Copyright © 2017 Mohammad Zulqurnain. All rights reserved.
//

import Foundation
import UIKit

/**
 # Common #
 Class for certain common interface functionality related to the UI elements
 */

//MARK: - IBDesignable for TextField
@IBDesignable open class UITextFieldRoundedCorner: UITextField {
 

    @IBInspectable dynamic open var cornerRadius: Float = 0.4 {
        didSet {
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    @IBInspectable dynamic open var borderWidth: Float = 1.0{
        didSet{
            self.layer.borderWidth = CGFloat(borderWidth)
        }
        
    }
    @IBInspectable dynamic open var borderColor: UIColor?{
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}

//MARK: - IBDesignable for Button
@IBDesignable open class UIButtonRoundedCorner: UIButton {
    @IBInspectable dynamic open var cornerRadius: Float = 0.4 {
        didSet {
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    @IBInspectable dynamic open var borderWidth: Float = 1.0{
        didSet{
            self.layer.borderWidth = CGFloat(borderWidth)
        }
        
    }
    @IBInspectable dynamic open var borderColor: UIColor?{
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
}

//MARK: - IBDesignable for Image View
@IBDesignable open class UIImageViewRoundedCorner: UIImageView {
    @IBInspectable dynamic open var cornerRadius: Float = 0.4 {
        didSet {
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    @IBInspectable dynamic open var borderWidth: Float = 1.0{
        didSet{
            self.layer.borderWidth = CGFloat(borderWidth)
        }
        
    }
    @IBInspectable dynamic open var borderColor: UIColor?{
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
}

//MARK: - IBDesignable for Label
@IBDesignable open class UILabelRounderCorner: UILabel {
    @IBInspectable dynamic open var cornerRadius: Float = 0.4 {
        didSet {
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    @IBInspectable dynamic open var borderWidth: Float = 1.0{
        didSet{
            self.layer.borderWidth = CGFloat(borderWidth)
        }
        
    }
    @IBInspectable dynamic open var borderColor: UIColor?{
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}

//MARK: - IBDesignable for View
@IBDesignable open class UIViewRounderCorner: UIView {
    @IBInspectable dynamic open var cornerRadius: Float = 0.4 {
        didSet {
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    @IBInspectable dynamic open var borderWidth: Float = 1.0{
        didSet{
            self.layer.borderWidth = CGFloat(borderWidth)
        }
        
    }
    @IBInspectable dynamic open var borderColor: UIColor?{
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}


//MARK: - IBDesignable for UITableViewCustomBorder
@IBDesignable open class UITableCustomBorder: UITableView {
    @IBInspectable dynamic open var cornerRadius: Float = 0.4 {
        didSet {
            self.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    @IBInspectable dynamic open var borderWidth: Float = 1.0{
        didSet{
            self.layer.borderWidth = CGFloat(borderWidth)
        }
        
    }
    @IBInspectable dynamic open var borderColor: UIColor?{
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
