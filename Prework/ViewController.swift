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
    @IBOutlet weak var splitBillLabel: UILabel!
    @IBOutlet weak var splitBillCounter: UIStepper!
    @IBOutlet weak var splitBillNumPersons: UILabel!
    @IBOutlet weak var splitBillBackground: UIImageView!
    @IBOutlet weak var dividedTotalBackground: UIImageView!
    @IBOutlet weak var dividedTotalLabel: UILabel!
    @IBOutlet weak var perPersonLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "TTC Tip Calculator"
        billAmountTextField.becomeFirstResponder()
        tipValueBox.layer.cornerRadius = 10
        billAmountBox.layer.cornerRadius = 10
        totalLabelBox.layer.cornerRadius = 10
        splitBillBackground.layer.cornerRadius = 10
        dividedTotalBackground.layer.cornerRadius = 10
        billAmountBox.backgroundColor = .systemBlue
        tipValueBox.backgroundColor = .systemBlue
        totalLabelBox.backgroundColor = .systemBlue
        totalLabelBox.alpha = 0
        totalLabel.alpha = 0
        totalIndicator.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        splitBillLabel.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        splitBillBackground.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        splitBillCounter.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        splitBillNumPersons.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        dividedTotalBackground.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        dividedTotalLabel.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        perPersonLabel.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
    }

    @IBAction func changePersonCounter(_ sender: Any) {
        if (self.splitBillCounter.value > 1)
        {
            self.splitBillNumPersons.text = (String(format: "%.0f", splitBillCounter.value) + " people")
        } else {
            self.splitBillNumPersons.text = (String(format: "%.0f", splitBillCounter.value) + " person")
        }
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Get bill amount from the text field input
        let bill = Double(billAmountTextField.text!) ?? 0
        
        // Get total tip by multiplying tip * tipValue
        let tipValue = Double(tipValueField.text!) ?? 0
        let tipPercentage = tipValue*0.01
        let tip = bill * tipPercentage
        let total = (bill+tip)
        let dividedTotal = total/splitBillCounter.value
        

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
                    })
                } else {
                    self.tipValueBox.backgroundColor = .systemGreen
                }
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
            let formattedDividedNum = dividedTotal as NSNumber
            UIView.animate(withDuration: 0.3, animations:
            {
                self.totalLabel.text = currencyFormatter.string(from: formattedNum)
                self.totalLabelBox.alpha = 0.2
                self.totalLabel.alpha = 1
                self.totalIndicator.alpha = 1
                self.totalLabelBox.frame = CGRect(x:0, y:420, width:414, height:570)
                self.totalIndicator.frame = CGRect(x:158,y:440,width:99, height:39)
                self.totalLabel.frame = CGRect(x:16, y:460, width:383, height:144)
            })
            if (splitBillCounter.isHidden == false && splitBillCounter.value>1)
            {
                self.dividedTotalLabel.text = currencyFormatter.string(from:formattedDividedNum)
                UIView.animate(withDuration: 0.3, animations: {
                    self.dividedTotalBackground.frame = CGRect(x:0, y:316, width:240, height:79)
                    self.dividedTotalLabel.frame = CGRect(x:20, y:323, width:203, height:36)
                    self.perPersonLabel.frame = CGRect(x:20, y:359, width:203, height:36)
                })
            } else {
                self.dividedTotalLabel.text = currencyFormatter.string(from:formattedDividedNum)
                UIView.animate(withDuration: 0.3, animations: {
                    self.dividedTotalBackground.frame = CGRect(x:-350, y:316, width:240, height:79)
                    self.dividedTotalLabel.frame = CGRect(x:-350, y:323, width:203, height:36)
                    self.perPersonLabel.frame = CGRect(x:-350, y:359, width:203, height:36)
                })
            }
        } else {
            UIView.animate(withDuration: 0.3, animations:
            {
                self.totalLabel.alpha = 0
                self.totalLabelBox.alpha = 0
                self.totalIndicator.alpha = 0
                self.totalLabelBox.frame = CGRect(x:0, y:1000, width: 414, height:570)
                self.totalIndicator.frame = CGRect(x:158,y:1000,width:99, height:39)
                self.totalLabel.frame = CGRect(x:0, y:1000, width:383, height:144)
                self.dividedTotalBackground.frame = CGRect(x:-350, y:316, width:240, height:79)
                self.dividedTotalLabel.frame = CGRect(x:-350, y:323, width:203, height:36)
                self.perPersonLabel.frame = CGRect(x:-350, y:359, width:203, height:36)
            })
        }
    }
}
