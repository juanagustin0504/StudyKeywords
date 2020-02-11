//
//  UserDefaultsViewController.swift
//  StudyKeyword001
//
//  Created by Webcash on 2020/02/10.
//  Copyright © 2020 Moonift. All rights reserved.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var userNameLb: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if UserDefaults.standard.string(forKey: "userName") == "", UserDefaults.standard.string(forKey: "userName") == nil {
            userNameLb.text = "Unknown User"
        } else {
            userNameLb.text = UserDefaults.standard.string(forKey: "userName") ?? "Unknown User"
        }
        
    }

    @IBAction func gotoSettingsScreen(_ sender: UIButton) {
        self.navigationController?.pushViewController(self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController, animated: true)
    }
    
}
