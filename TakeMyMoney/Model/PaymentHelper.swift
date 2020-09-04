//
//  PaymentHelper.swift
//  TakeMyMoney
//
//  Created by Adrian Galecki on 8/31/20.
//  Copyright © 2020 Adrian Galecki. All rights reserved.
//

import Foundation

enum InputFieldType {
    case CARD_NUM, VALID_UNTIL, CVV_NUM
}

enum PaymentMethod {
    case PAYPAL, CREDIT_CARD, ERROR
}

struct PaymentInformation {
    private(set) public var totalPrice: Double
    private(set) public var creditCard: String
    private(set) public var expirationDate: String
    private(set) public var cvvNumber: String
    private(set) public var fullName: String
    private(set) public var paymentMethod: PaymentMethod
    
    init(totalPrice: Double, creditCard: String, expirationDate: String, cvvNumber: String, fullName: String, paymentMethod: PaymentMethod) {
        self.totalPrice = totalPrice
        self.creditCard = creditCard
        self.expirationDate = expirationDate
        self.cvvNumber = cvvNumber
        self.fullName = fullName
        self.paymentMethod = paymentMethod
    }
}
