//
//  SettingsViewController.swift
//  StudyKeyword001
//
//  Created by Webcash on 2020/02/11.
//  Copyright © 2020 Moonift. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var editUserName: UITextField!
    @IBOutlet weak var notificationSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let userName = UserDefaults.standard.string(forKey: "userName") {
            editUserName.text = userName
        } else {
            editUserName.placeholder = "Unknown User"
        }
        
        notificationSwitch.isOn = UserDefaults.standard.bool(forKey: "switch")
    }
    
    @IBAction func saveData(_ sender: UIButton) {
        if editUserName.text == "" {
            UserDefaults.standard.set(nil, forKey: "userName")
        } else {
            UserDefaults.standard.set(editUserName.text, forKey: "userName")
        }
        
        UserDefaults.standard.set(notificationSwitch.isOn, forKey: "switch")
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
