//
//  SettingsViewController.swift
//  Prework
//
//  Created by Tony Makaj on 11/22/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var background1Setting: UIImageView!
    @IBOutlet weak var background2Setting: UIImageView!
    @IBOutlet weak var background3Setting: UIImageView!
    @IBOutlet weak var splitBillSwitch: UISwitch!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var manualTipSwitch: UISwitch!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Settings"
        background1Setting.layer.cornerRadius = 10
        background2Setting.layer.cornerRadius = 10
        background3Setting.layer.cornerRadius = 10
        checkSplitBillSwitch()
        checkDarkModeSwitch()
        checkManualTipSwitch()
    }

    @IBAction func splitBill(_ sender: Any) {
        if (splitBillSwitch.isOn)
        {
            UserDefaults.standard.set(true, forKey: "sbSwitchIsOn")
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.set(false, forKey: "sbSwitchIsOn")
            UserDefaults.standard.synchronize()
        }
    }
    
    @IBAction func darkMode(_ sender: Any) {
        if (darkModeSwitch.isOn)
        {
            overrideUserInterfaceStyle = .dark
            UserDefaults.standard.set(true, forKey: "DARKMODE")
            UserDefaults.standard.synchronize()
        } else {
            overrideUserInterfaceStyle = .light
            UserDefaults.standard.set(false, forKey: "DARKMODE")
            UserDefaults.standard.synchronize()
        }
    }
    @IBAction func manualTip(_ sender: Any) {
        if (manualTipSwitch.isOn)
        {
            UserDefaults.standard.set(true, forKey: "MANUALTIP")
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.set(false, forKey: "MANUALTIP")
            UserDefaults.standard.synchronize()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        checkDarkModeSwitch()
    }
    
    func checkSplitBillSwitch() {
        if (UserDefaults.standard.bool(forKey: "sbSwitchIsOn") == true)
        {
            splitBillSwitch.setOn(true, animated: false)
        }
        else {
            splitBillSwitch.setOn(false, animated: false)
        }
    }
    
    func checkDarkModeSwitch() {
        if (UserDefaults.standard.bool(forKey: "DARKMODE")) {
            overrideUserInterfaceStyle = .dark
            darkModeSwitch.setOn(true, animated: false)
        } else {
            overrideUserInterfaceStyle = .light
            darkModeSwitch.setOn(false, animated: false)
        }
    }
    
    func checkManualTipSwitch() {
        if (UserDefaults.standard.bool(forKey: "MANUALTIP")) {
            manualTipSwitch.setOn(true, animated: false)
        } else {
            manualTipSwitch.setOn(false, animated: false)
        }
    }
}
