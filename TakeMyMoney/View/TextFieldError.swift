//
//  TextFieldError.swift
//  TakeMyMoney
//
//  Created by Adrian Galecki on 9/29/20.
//  Copyright © 2020 Adrian Galecki. All rights reserved.
//

import UIKit

@IBDesignable
class TextFieldError: UITextField {
    
    var isError = true

    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    
    override func awakeFromNib() {
        customizeView()
    }
    
    func customizeView() {
        print("In the customize text field func")
        if isError {
            print("Error = true")
            layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
            layer.borderWidth = 2.0
        }
        else {
            print("Error = false ")
            layer.borderColor = #colorLiteral(red: 0.9813231826, green: 0.9813460708, blue: 0.9813337922, alpha: 1)
            layer.borderWidth = 0.0
        }
        
    }
    
    

}
