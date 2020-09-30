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

struct CreditCardPayment {
    private(set) public var totalPrice: Double
    private(set) public var creditCard: String
    private(set) public var expirationDate: String
    private(set) public var cvvNumber: String
    private(set) public var fullName: String
    private(set) public var savePaymentMethod: Bool
    
    init(totalPrice: Double, creditCard: String, expirationDate: String, cvvNumber: String, fullName: String, savePaymentMethod: Bool) {
        self.totalPrice = totalPrice
        self.creditCard = creditCard
        self.expirationDate = expirationDate
        self.cvvNumber = cvvNumber
        self.fullName = fullName
        self.savePaymentMethod = savePaymentMethod
    }
}

struct PaypalPayment {
    private(set) public var email: String
    private(set) public var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
