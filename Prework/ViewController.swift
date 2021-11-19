//
//  ViewController.swift
//  Prework
//
//  Created by Tony Makaj on 11/16/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "TTC Tip Calculator"
        billAmountTextField.becomeFirstResponder()
    }

    @IBAction func calculateTip(_ sender: Any) {
        // Get bill amount from the text field input
        let bill = Double(billAmountTextField.text!) ?? 0
        
        // Get total tip by multiplying tip * tipPercentage
        let tipPercentage = Double(tipPercentageField.text!) ?? 0
        let tip = bill * tipPercentage
        let total = bill + tip
        
        // Animations
        if (billAmountTextField.text?.isEmpty ?? true) {
            UIView.animate(withDuration: 0.2, animations: {
                self.billAmountTextField.backgroundColor = .none
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.billAmountTextField.backgroundColor = .systemGreen
            })
        }
        
        if (tipPercentageField.text?.isEmpty ?? true) {
            UIView.animate(withDuration: 0.2, animations: {
                self.tipPercentageField.backgroundColor = .none
            })
        } else if (tipPercentage >= 15) {
            UIView.animate(withDuration: 0.2, animations: {
                self.tipPercentageField.backgroundColor = .systemGreen
            })
        } else {
            UIView.animate(withDuration: 0.2, delay: 1, animations: {
                self.tipPercentageField.backgroundColor = .systemRed
            })
        }
        //Update tip amount label
        //totalLabel.text = String(format: "$%.2f", tip)
        //Update total amount
        //totalLabel.text = String(format: "$%.2f", total)
    }
}
