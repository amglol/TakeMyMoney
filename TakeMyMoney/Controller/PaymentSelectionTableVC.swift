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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func creditCardTextFieldValueChanged(_ sender: UITextField) {
        guard let creditCardNumber = creditCardInputField.text else { return }
        let isLimitedReached = checkInputFieldLength(inputType: InputFieldType.CARD_NUM, inputValue: creditCardNumber)
        
        if isLimitedReached {
            createCustomAlert(alertTitle: "Limit Reached", message: "You are attempting to enter invalid digits.")
            creditCardInputField.text = ""
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
            if inputValue.count > 4 {
                isLimitReached = true
            }
        case .VALID_UNTIL:
            if inputValue.count > 7 {
                isLimitReached = true
            }
        default:
            print("Error")
        }
        return isLimitReached
    }
    
    func createCustomAlert(alertTitle: String, message: String) {
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }

}
