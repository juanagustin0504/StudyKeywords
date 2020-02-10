//
//  MainViewController.swift
//  StudyKeyword001
//
//  Created by Webcash on 2020/02/10.
//  Copyright © 2020 Moonift. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func gotoKeychainScreen(_ sender: UIButton) {
        let keychainSb = UIStoryboard(name: "Keychain", bundle: nil)
        let keychainVc = keychainSb.instantiateViewController(withIdentifier: "KeychainViewController") as! KeychainViewController
        self.navigationController?.pushViewController(keychainVc, animated: true)
    }
    
    @IBAction func gotoCoreDataScreen(_ sender: UIButton) {
    }
    
    @IBAction func gotoUserDefaultsScreen(_ sender: UIButton) {
    }
    
}
