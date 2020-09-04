//
//  RoundedButton.swift
//  TakeMyMoney
//
//  Created by Adrian Galecki on 8/26/20.
//  Copyright © 2020 Adrian Galecki. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    override func prepareForInterfaceBuilder() {
        customizeView()
    }

    override func awakeFromNib() {
        customizeView()
    }
    
    func customizeView() {
        layer.cornerRadius = 15.0
    }

}
