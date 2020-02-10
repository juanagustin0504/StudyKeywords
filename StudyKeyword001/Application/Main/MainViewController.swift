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
        let coredataSb = UIStoryboard(name: "CoreData", bundle: nil)
        let coredataVc = coredataSb.instantiateViewController(withIdentifier: "CoreDataViewController") as! CoreDataViewController
        self.navigationController?.pushViewController(coredataVc, animated: true)
    }
    
    @IBAction func gotoUserDefaultsScreen(_ sender: UIButton) {
        let userdefaultsSb = UIStoryboard(name: "UserDefaults", bundle: nil)
        let userdefaultsVc = userdefaultsSb.instantiateViewController(withIdentifier: "UserDefaultsViewControllr") as! UserDefaultsViewController
        self.navigationController?.pushViewController(userdefaultsVc, animated: true)
    }
    
}
