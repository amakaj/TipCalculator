//
//  ViewController.swift
//  Prework - TTC Calculator App
//
//  Created by Tony Makaj on 11/16/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipValueField: UITextField!
    @IBOutlet weak var tipValueBox: UIImageView!
    @IBOutlet weak var billAmountBox: UIImageView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalLabelBox: UIImageView!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalIndicator: UILabel!
    @IBOutlet weak var moreTipBox: UIImageView!
    @IBOutlet weak var moreTipLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "TTC Tip Calculator"
        billAmountTextField.becomeFirstResponder()
        tipValueBox.layer.cornerRadius = 10
        billAmountBox.layer.cornerRadius = 10
        totalLabelBox.layer.cornerRadius = 10
        moreTipBox.layer.cornerRadius = 10
        moreTipLabel.text = "Tip some more!"
        billAmountBox.backgroundColor = .systemBlue
        tipValueBox.backgroundColor = .systemBlue
        totalLabelBox.backgroundColor = .systemBlue
        moreTipBox.alpha = 0
        moreTipLabel.alpha = 0
        totalLabelBox.alpha = 0
        totalLabel.alpha = 0
        totalIndicator.alpha = 0
    }

    @IBAction func calculateTip(_ sender: Any) {
        // Get bill amount from the text field input
        let bill = Double(billAmountTextField.text!) ?? 0
        
        // Get total tip by multiplying tip * tipValue
        let tipValue = Double(tipValueField.text!) ?? 0
        let tipPercentage = tipValue*0.01
        let tip = bill * tipPercentage
        let total = bill + tip

        // Animations
        if (billAmountTextField.text?.isEmpty ?? true) {
            UIView.animate(withDuration: 0.2, animations: {
                self.billAmountBox.backgroundColor = .systemBlue
                self.billAmountBox.frame = CGRect(x: 16, y: 98, width: 383, height: 72)
                self.billAmountTextField.frame = CGRect(x: 16, y: 98, width: 383, height: 72)
                self.billAmountLabel.frame = CGRect(x: -125, y: 103, width: 100, height: 70)
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.billAmountBox.backgroundColor = .systemGreen
                self.billAmountBox.frame = CGRect(x: 120, y: 98, width: 267, height: 72)
                self.billAmountTextField.frame = CGRect(x: 120, y: 98, width: 267, height: 72)
                self.billAmountLabel.frame = CGRect(x: 16, y: 103, width: 100, height: 70)
            })
        }
        
        if (tipValueField.text?.isEmpty ?? true) {
            UIView.animate(withDuration: 0.2, animations: {
                self.tipValueBox.backgroundColor = .systemBlue
                self.tipValueBox.frame = CGRect(x: 16, y: 178, width: 383, height: 37)
                self.tipValueField.frame = CGRect(x: 16, y: 178, width: 383, height: 37)
                self.tipAmountLabel.frame = CGRect(x: -200, y: 180, width: 181, height: 33)
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                if (tipValue < 15)
                {
                    UIView.animate(withDuration:0.2, delay: 0.2, animations: {
                        self.tipValueBox.backgroundColor = .systemRed
                        /* supposed to give a suggestion to tip more but could not get it to work
                        self.moreTipBox.frame = CGRect(x:265, y:216, width:104, height:31)
                        self.moreTipLabel.frame = CGRect(x:273, y:216, width:88, height:31)
                        self.moreTipBox.alpha = 0.2
                        self.moreTipLabel.alpha = 1
                         */
                    })
                } else {
                    self.tipValueBox.backgroundColor = .systemGreen
                }
                /* supposed to make suggestion go away but could not get this specific part to work
                if (isTipValueFieldEmpty)
                {
                    self.moreTipLabel.alpha = 0
                    self.moreTipBox.alpha = 0
                    self.moreTipBox.frame = CGRect(x:250, y:205, width:104, height:31)
                    self.moreTipLabel.frame = CGRect(x:281, y:205, width:88, height:31)
                }
                 */
                self.tipValueBox.frame = CGRect(x: 205, y: 178, width: 174, height: 37)
                self.tipValueField.frame = CGRect(x: 205, y: 178, width: 174, height: 37)
                self.tipAmountLabel.frame = CGRect(x: 16, y: 180, width: 181, height: 33)
            })
        }
        //Update total amount
        if ((tipValueField.text?.isEmpty == false) && (billAmountTextField.text?.isEmpty == false))
        {
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.locale = Locale.current
            let formattedNum = total as NSNumber
            UIView.animate(withDuration: 0.3, animations:
            {
                //self.totalLabel.text = String(format: "$%.2f", total)
                self.totalLabel.text = currencyFormatter.string(from: formattedNum)
                self.totalLabelBox.alpha = 0.2
                self.totalLabel.alpha = 1
                self.totalIndicator.alpha = 1
                self.totalLabelBox.frame = CGRect(x:0, y:420, width:414, height:570)
                self.totalIndicator.frame = CGRect(x:158,y:440,width:99, height:39)
                self.totalLabel.frame = CGRect(x:16, y:460, width:383, height:144)
            })
        } else {
            UIView.animate(withDuration: 0.3, animations:
            {
                self.totalLabel.alpha = 0
                self.totalLabelBox.alpha = 0
                self.totalIndicator.alpha = 0
                self.totalLabelBox.frame = CGRect(x:0, y:1000, width: 414, height:570)
                self.totalIndicator.frame = CGRect(x:158,y:1000,width:99, height:39)
                self.totalLabel.frame = CGRect(x:0, y:1000, width:383, height:144)
            })
        }
    }
}
