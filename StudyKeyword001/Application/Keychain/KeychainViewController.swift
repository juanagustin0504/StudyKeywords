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
        
        var result: String = self.passwordText.text ?? ""
        
        KeychainWrapper.standard.set(result, forKey: "userPassword")
        
        result += " was saved successful 😃"
        print(result)
        alert(title: "Success", message: result)
        self.view.endEditing(true)
        
        
    }
    
    @IBAction func retrievePasswordButtonTapped(_ sender: UIButton) {
        
        var result: String = self.passwordText.text ?? ""
        
        guard let retrievedPassword = KeychainWrapper.standard.string(forKey: "userPassword") else {
            result = result + " Password is nil"
            print(result)
            alert(title: "Alert", message: result)
            return
        }
        
        result = "Retrieved Password is: \(retrievedPassword)"
        
        print(result)
        alert(title: "Alert", message: result)
    }
    
    @IBAction func removePasswordButtonTapped(_ sender: UIButton) {
        
        var result: String = self.passwordText.text ?? ""
        
        KeychainWrapper.standard.remove(key: "userPassword")
        
        result += " was removed successful 😃"
        print(result)
        alert(title: "Success", message: result)
    }
    
    private func alert(title: String = "", message: String = "") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}

