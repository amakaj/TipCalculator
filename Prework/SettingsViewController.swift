//
//  SettingsViewController.swift
//  Prework
//
//  Created by Tony Makaj on 11/22/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var background1Setting: UIImageView!
    @IBOutlet weak var splitBillSwitch: UISwitch!
    let SPLIT_BILL = "sbSwitchIsOn"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Settings"
        background1Setting.layer.cornerRadius = 10
        checkSplitBillSwitch()

    }
    
    func checkSplitBillSwitch() {
        if (UserDefaults.standard.bool(forKey: SPLIT_BILL))
        {
            splitBillSwitch.setOn(true, animated: false)
        }
        else {
            splitBillSwitch.setOn(false, animated: false)
        }
    }

    @IBAction func splitBill(_ sender: Any) {
        if (splitBillSwitch.isOn)
        {
            UserDefaults.standard.set(true, forKey: SPLIT_BILL)
            UserDefaults.standard.synchronize()
        } else {
            UserDefaults.standard.set(false, forKey: SPLIT_BILL)
            UserDefaults.standard.synchronize()
        }
    }
    // MARK: - Navigation

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
     */
}
