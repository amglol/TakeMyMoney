//
//  PaymentSelectionTableVC.swift
//  TakeMyMoney
//
//  Created by Adrian Galecki on 8/26/20.
//  Copyright © 2020 Adrian Galecki. All rights reserved.
//

import UIKit

class PaymentSelectionTableVC: UITableViewController {
    
    @IBOutlet weak var creditCardInputField: UITextField!
    @IBOutlet weak var validUntilInputField: UITextField!
    @IBOutlet weak var cvvInputField: UITextField!
    @IBOutlet weak var nameInputfield: UITextField!
    
    //payment buttons
    @IBOutlet weak var paypalBtnOutlet: UIButton!
    @IBOutlet weak var creditCardBtnOutlet: UIButton!
    
    var isLimitReached = false
    var paypalSelected = false
    var creditCardSelected = false

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func proceedToPayment(_ sender: UIButton) {
        let paymentValues = payment
        print("The payment details are: \(payment)")
    }
    
    @IBAction func paymentButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            UpdateButtonView(enterTheButtonOutlet: paypalBtnOutlet)
        case 2:
            UpdateButtonView(enterTheButtonOutlet: creditCardBtnOutlet)
        default:
            print("error")
        }
    }
    
    @IBAction func inputFieldValueChanged(_ sender: UITextField) {
        switch sender {
        case creditCardInputField:
            guard let creditCardNumber = creditCardInputField.text else { return }
            isLimitReached = checkInputFieldLength(inputType: InputFieldType.CARD_NUM, inputValue: creditCardNumber)
            
            if isLimitReached {
                createCustomAlert(alertTitle: "Limit Reached", message: "You are attempting to enter invalid digits.")
                creditCardInputField.text = ""
            }
        case validUntilInputField:
            guard let validUntilNumber = validUntilInputField.text else { return }
            isLimitReached = checkInputFieldLength(inputType: InputFieldType.VALID_UNTIL, inputValue: validUntilNumber)
            
            if validUntilNumber.count == 2 {
                validUntilInputField.text = validUntilNumber + "/"
            }
            
            if isLimitReached {
                createCustomAlert(alertTitle: "Limit Reached", message: "You are attempting to enter invalid digits.")
                validUntilInputField.text = ""
            }
        case cvvInputField:
            guard let cvvNumber = cvvInputField.text else { return }
            isLimitReached = checkInputFieldLength(inputType: InputFieldType.CVV_NUM, inputValue: cvvNumber)
            
            if isLimitReached {
                createCustomAlert(alertTitle: "Limit Reached", message: "You are attempting to enter invalid digits.")
                cvvInputField.text = ""
            }
        default:
            print("error")
        }
    }
    
    func checkInputFieldLength(inputType: InputFieldType, inputValue: String) -> Bool {
        var isLimitReached = false
        
        switch inputType {
        case .CARD_NUM:
            if inputValue.count > 16 {
                isLimitReached = true
            }
        case .CVV_NUM:
            if inputValue.count > 3 {
                isLimitReached = true
            }
        case .VALID_UNTIL:
            if inputValue.count > 7 {
                isLimitReached = true
            }
        }
        return isLimitReached
    }
    
    func UpdateButtonView(enterTheButtonOutlet btnOutlet: UIButton) {
        switch btnOutlet {
        case paypalBtnOutlet:
            paypalSelected = true
            creditCardSelected = false
        case creditCardBtnOutlet:
            paypalSelected = false
            creditCardSelected = true
        default:
            print("error")
        }
        
        if paypalSelected {
            paypalBtnOutlet.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
            creditCardBtnOutlet.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        }
        else {
            paypalBtnOutlet.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            creditCardBtnOutlet.backgroundColor = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
        }
    }
    
    var payment: PaymentInformation? {
        
        let totalPrice = 5950.00
        let creditCardNum = creditCardInputField.text ?? ""
        let expirationDate = validUntilInputField.text ?? ""
        let cvvNumber = cvvInputField.text ?? ""
        let fullName = nameInputfield.text ?? ""
        
        var paymentMethod = PaymentMethod.ERROR
        
        if paypalSelected {
            paymentMethod = PaymentMethod.PAYPAL
        }
        else {
            paymentMethod = PaymentMethod.CREDIT_CARD
        }
        
        return PaymentInformation(totalPrice: totalPrice, creditCard: creditCardNum, expirationDate: expirationDate, cvvNumber: cvvNumber, fullName: fullName, paymentMethod: paymentMethod)
    }
    
    func createCustomAlert(alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
