//
//  ViewController.swift
//  StudyKeyword001
//
//  Created by Webcash on 2020/02/10.
//  Copyright © 2020 Moonift. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class KeychainViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func savePasswordButtonTapped(_ sender: UIButton) {
        if let password = passwordText.text {
            let saveSuccessful: Bool = KeychainWrapper.standard.set(password, forKey: "userPassword")
            print("Save was successful: \(saveSuccessful)")
            self.view.endEditing(true)
        }
        
    }
    
    @IBAction func retrievePasswordButtonTapped(_ sender: UIButton) {
        
        guard let retrievedPassword = KeychainWrapper.standard.string(forKey: "userPassword") else {
            print("Password is nil")
            return
        }
        print("Retrieved Password is: \(retrievedPassword)")
    }
    
    @IBAction func removePasswordButtonTapped(_ sender: UIButton) {
        let removeSuccessful: Bool = KeychainWrapper.standard.remove(key: "userPassword")
        print("Remove was successful: \(removeSuccessful)")
    }
    
}

