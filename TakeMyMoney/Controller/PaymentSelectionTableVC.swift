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
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var savePaymentOutlet: UISwitch!
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var passwordOutlet: UITextField!
    
    //payment buttons
    @IBOutlet weak var paypalBtnOutlet: UIButton!
    @IBOutlet weak var creditCardBtnOutlet: UIButton!
    
    var isLimitReached = false
    var paypalSelected = false
    var creditCardSelected = false
    var isPaypalFieldsShown = false
    
    let cardNumberCellIndexPath = IndexPath(row: 2, section: 0)
    let validUntilCellIndexPath = IndexPath(row: 3, section: 0)
    let cardHolderCellIndexPath = IndexPath(row: 4, section: 0)
    let saveCardDataIndexPath = IndexPath(row: 5, section: 0)
    let payPaylIndexPath = IndexPath(row: 6, section: 0)
    
    let price = 5725.50

    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPriceLbl.text = "\(price)"
    }
    
    @IBAction func proceedToPayment(_ sender: UIButton) {
        var paymentValues: Any
        
        if paypalSelected && !creditCardSelected {
            if let payment = paypalPayment {
                paymentValues = payment
                if payment.email.isEmpty || payment.password.count <= 0 {
                    print("Empty paypal payment inforamtion")
                }
                print("The payment details are: \(String(describing: paymentValues))")
            }
            else {
                print("Empty paypal payment inforamtion")
                
            }
        }
        else if creditCardSelected && !paypalSelected {
            if let payment = creditCardPayment {
                paymentValues = payment
                print("The payment details are: \(String(describing: paymentValues))")
            }
            else {
                print("Empty credit card payment information")
            }
        }
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
            print("Paypal selected")
            paypalSelected = true
            creditCardSelected = false
            tableView.reloadData()
        case creditCardBtnOutlet:
            print("Credit card selected")
            paypalSelected = false
            creditCardSelected = true
            tableView.reloadData()
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
    
    var creditCardPayment: CreditCardPayment? {
        
        let totalPrice = price
        let creditCardNum = creditCardInputField.text ?? ""
        let expirationDate = validUntilInputField.text ?? ""
        let cvvNumber = cvvInputField.text ?? ""
        let fullName = nameInputfield.text ?? ""
        let savePayment = savePaymentOutlet.isOn
        
        return CreditCardPayment(totalPrice: totalPrice, creditCard: creditCardNum, expirationDate: expirationDate, cvvNumber: cvvNumber, fullName: fullName, savePaymentMethod: savePayment)
    }
    
    var paypalPayment: PaypalPayment? {
        let email = emailOutlet.text ?? ""
        let password = passwordOutlet.text ?? ""
        
        if email.isEmpty || password.count <= 0 {
            print("Empty paypal payment inforamtion")
        }
        
        return PaypalPayment(email: email, password: password)
    }
    
    func createCustomAlert(alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected section: \(indexPath.section)")
        print("Selected row: \(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("paypal btn is selected right? \(paypalSelected)")
        tableView.beginUpdates()
        tableView.endUpdates()
        switch (indexPath.section, indexPath.row) {
        case (cardNumberCellIndexPath.section, cardNumberCellIndexPath.row):
            print("Case got hit")
            if paypalSelected {
                tableView.beginUpdates()
                tableView.endUpdates()
                return 0.0
            }
            else {
                return 100.0
            }
        case (validUntilCellIndexPath.section, validUntilCellIndexPath.row):
            if paypalSelected {
                tableView.beginUpdates()
                tableView.endUpdates()
                return 0.0
            }
            else {
                return 100.0
            }
        case (cardHolderCellIndexPath.section, cardHolderCellIndexPath.row):
            if paypalSelected {
                tableView.beginUpdates()
                tableView.endUpdates()
                return 0.0
            }
            else {
                return 100.0
            }
        case (saveCardDataIndexPath.section, saveCardDataIndexPath.row):
            if paypalSelected {
                tableView.beginUpdates()
                tableView.endUpdates()
                return 0.0
            }
            else {
                return 100.0
            }
        case (payPaylIndexPath.section, payPaylIndexPath.row):
            if paypalSelected {
                tableView.beginUpdates()
                tableView.endUpdates()
                return 250.0
            }
            else {
                return 0.0
            }
        default:
            print("default got hit")
            return 100.0
        }
        
    }

}
