//
//  ViewController.swift
//  Prework - TTC Calculator App
//
//  Created by Anthony Makaj

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
    @IBOutlet weak var tipBackground: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipValueLabel: UILabel!
    @IBOutlet weak var segmentedTipControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        billAmountTextField.becomeFirstResponder()
        tipValueBox.layer.cornerRadius = 10
        billAmountBox.layer.cornerRadius = 10
        totalLabelBox.layer.cornerRadius = 10
        splitBillBackground.layer.cornerRadius = 10
        dividedTotalBackground.layer.cornerRadius = 10
        tipBackground.layer.cornerRadius = 10
        billAmountBox.backgroundColor = .systemBlue
        tipValueBox.backgroundColor = .systemBlue
        totalLabelBox.backgroundColor = .systemBlue
        totalLabelBox.alpha = 0
        totalLabel.alpha = 0
        totalIndicator.alpha = 0
        viewWillAppear(false)
    }
    
    //Executes when ViewController (main page) appears on the foreground
    override func viewWillAppear(_ animated: Bool) {
        //Checks if dark mode is enabled, and enable it on ViewController if so
        if (UserDefaults.standard.bool(forKey: "DARKMODE") == true)
        {
            overrideUserInterfaceStyle = .dark
        } else if (UserDefaults.standard.bool(forKey: "DARKMODE") == false)
        {
            overrideUserInterfaceStyle = .light
        }
        //Load saved values from the bill amount, manual tip percentage (or segmented tip control), split bill counter (and respective number of persons label), and check if manual tip is enabled
        billAmountTextField.text = UserDefaults.standard.string(forKey: "BILLAMOUNT")
        tipValueField.text = UserDefaults.standard.string(forKey: "TIPVALUE")
        splitBillLabel.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        splitBillBackground.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        splitBillCounter.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        splitBillNumPersons.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        dividedTotalBackground.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        dividedTotalLabel.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        perPersonLabel.isHidden = !UserDefaults.standard.bool(forKey: "sbSwitchIsOn")
        tipValueField.isHidden = !UserDefaults.standard.bool(forKey: "MANUALTIP")
        tipValueBox.isHidden = !UserDefaults.standard.bool(forKey: "MANUALTIP")
        segmentedTipControl.isHidden = UserDefaults.standard.bool(forKey: "MANUALTIP")
        segmentedTipControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "SELECTEDTIPSEGMENT")
        splitBillCounter.value = UserDefaults.standard.double(forKey: "SPLITBILLCOUNTER")
        //Updates the label that displays the number of persons to split bill
        if (self.splitBillCounter.value > 1)
        {
            self.splitBillNumPersons.text = (String(format: "%.0f", splitBillCounter.value) + " people")
        } else {
            self.splitBillNumPersons.text = (String(format: "%.0f", splitBillCounter.value) + " person")
        }
    }
    
    //When View Controller (main page) disappears, save existing values into UserDefaults
    override func viewWillDisappear(_ animated: Bool) {
        UserDefaults.standard.set(billAmountTextField.text, forKey: "BILLAMOUNT")
        UserDefaults.standard.set(tipValueField.text, forKey: "TIPVALUE")
        UserDefaults.standard.set(splitBillCounter.value, forKey: "SPLITBILLCOUNTER")
        UserDefaults.standard.set(segmentedTipControl.selectedSegmentIndex, forKey: "SELECTEDTIPSEGMENT")
        UserDefaults.standard.synchronize()
    }

    //When the number of "split bill" persons change, update label accordingly and save into UserDefaults
    @IBAction func changePersonCounter(_ sender: Any) {
        if (self.splitBillCounter.value > 1)
        {
            self.splitBillNumPersons.text = (String(format: "%.0f", splitBillCounter.value) + " people")
        } else {
            self.splitBillNumPersons.text = (String(format: "%.0f", splitBillCounter.value) + " person")
        }
        UserDefaults.standard.set(splitBillCounter.value, forKey: "SPLITBILLCOUNTER")
        UserDefaults.standard.synchronize()
    }
    
    //The meat and bones of the app! Calculate the tip when all the inputs are satisfied
    @IBAction func calculateTip(_ sender: Any) {
        // Get bill amount from the text field input
        let bill = Double(billAmountTextField.text!) ?? 0
        
        //Variable declarations
        let tipValue: Double
        let tipPercentage: Double
        let tip: Double
        let total: Double
        let dividedTotal: Double
        
        // Get total tip by multiplying tip * tipValue, and execute necessary code depending if "manual tip" is enabled
        if (!tipValueField.isHidden)
        {
            tipValue = Double(tipValueField.text!) ?? 0
            tipPercentage = tipValue*0.01
            tip = bill * tipPercentage
            total = (bill+tip)
            dividedTotal = total/splitBillCounter.value
        } else {
            let tipPercentages = [0.18, 0.20, 0.22]
            tipPercentage = tipPercentages[segmentedTipControl.selectedSegmentIndex]
            tip = bill * tipPercentage
            total = (bill+tip)
            dividedTotal = total/splitBillCounter.value
        }
        
        //Save existing values into UserDefaults
        UserDefaults.standard.set(billAmountTextField.text, forKey: "BILLAMOUNT")
        UserDefaults.standard.set(tipValueField.text, forKey: "TIPVALUE")
        UserDefaults.standard.set(segmentedTipControl.selectedSegmentIndex, forKey: "SELECTEDTIPSEGMENT")
        UserDefaults.standard.synchronize()

        //Animate the bill amount text field depending on if it's empty or not
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
        
        //Animate the tip value field depending on if its empty or not
        if ((tipValueField.text?.isEmpty ?? true) || (tipValueField.isHidden)) {
            UIView.animate(withDuration: 0.2, animations: {
                self.tipValueBox.backgroundColor = .systemBlue
                self.tipValueBox.frame = CGRect(x: 16, y: 178, width: 383, height: 37)
                self.tipValueField.frame = CGRect(x: 16, y: 178, width: 383, height: 37)
                self.tipAmountLabel.frame = CGRect(x: -200, y: 180, width: 181, height: 33)
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                //If tip percentage is less than 15%, change it to red because you should tip more :)
                if (tipPercentage < 0.15)
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
        //Update total amount after checking if all the requirements are satisfied
        if (((tipValueField.text?.isEmpty == false) || (tipValueField.isHidden == true)) && (billAmountTextField.text?.isEmpty == false))
        {
            //Format total & tip based on current locale and include thousands separators
            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = .currency
            currencyFormatter.locale = Locale.current
            let formattedNum = total as NSNumber
            let formattedDividedNum = dividedTotal as NSNumber
            let formattedTipNum = tip as NSNumber
            
            //Bring up the total!
            UIView.animate(withDuration: 0.3, animations:
            {
                self.totalLabel.text = currencyFormatter.string(from: formattedNum)
                self.tipValueLabel.text = currencyFormatter.string(from: formattedTipNum)
                self.totalLabelBox.alpha = 0.2
                self.totalLabel.alpha = 1
                self.totalIndicator.alpha = 1
                self.totalLabelBox.frame = CGRect(x:0, y:420, width:414, height:570)
                self.totalIndicator.frame = CGRect(x:158,y:440,width:99, height:39)
                self.totalLabel.frame = CGRect(x:16, y:460, width:383, height:144)
                self.tipBackground.frame = CGRect(x:270, y:316, width:150, height:79)
                self.tipLabel.frame = CGRect(x:317, y:326, width:57, height:30)
                self.tipValueLabel.frame = CGRect(x:285, y:367, width:120, height:21)
            })
            //Bring out the value that each person should pay if it is greater than 1 person
            if (splitBillCounter.isHidden == false && splitBillCounter.value>1)
            {
                self.dividedTotalLabel.text = currencyFormatter.string(from:formattedDividedNum)
                UIView.animate(withDuration: 0.3, animations: {
                    self.dividedTotalBackground.frame = CGRect(x:-10, y:316, width:240, height:79)
                    self.dividedTotalLabel.frame = CGRect(x:10, y:323, width:203, height:36)
                    self.perPersonLabel.frame = CGRect(x:10, y:359, width:203, height:36)
                })
            } else {
                //If it's less than one person or if split tip is disabled, make it go away!
                self.dividedTotalLabel.text = currencyFormatter.string(from:formattedDividedNum)
                UIView.animate(withDuration: 0.3, animations: {
                    self.dividedTotalBackground.frame = CGRect(x:-350, y:316, width:240, height:79)
                    self.dividedTotalLabel.frame = CGRect(x:-350, y:323, width:203, height:36)
                    self.perPersonLabel.frame = CGRect(x:-350, y:359, width:203, height:36)
                })
            }
        } else {
            //If a bill amount and tip are not specified, make the total go away since there's no way to calculate it without those two
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
                self.tipBackground.frame = CGRect(x:500, y:316, width:150, height:79)
                self.tipLabel.frame = CGRect(x:500, y:326, width:57, height:30)
                self.tipValueLabel.frame = CGRect(x:500, y:367, width:120, height:21)
            })
        }
    }
}
