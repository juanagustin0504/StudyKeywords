//
//  ViewController.swift
//  StudyKeyword001
//
//  Created by Webcash on 2020/02/10.
//  Copyright © 2020 Moonift. All rights reserved.
//

/*
 Keychain

 - [ios] Keychain으로 안전하게 데이터 저장하기

 UserDefaults는 단순한 데이터를 저장하는데는 문제가 없지만 민감한 비밀번호나, 인증서 같은 정보들, 혹은 사용자가 생각하기에 본인만의 민감한 정보들을 저장하기에는 안전하지 않다 -> Keychain을 이용하여 데이터 저장

 Keychain이란?
 민감한 데이터들을 안전하게 저장하는 것은 굉장히 복잡한 암호화 절차를 필요로 합니다. Keychain이라는 서비스를 사용합니다.

 Keychain은 하나의 암호화된 컨테이너이며 Keychain services API는 이처럼 민감한 데이터를 암호화하고 복호화하며 재사용하는 행위를 보다 쉽고 안전하게 사용할 수 있게끔 API를 제공합니다. 밑의 그림처럼 저장되는 단위를 Item이라 부릅니다.

 기본적으로 디바이스를 잠그면(Lock) Keychain 역시 잠기고 디바이스를 풀면(Unlock) Keychain 역시 풀립니다. 이렇게 Keychain이 잠긴 상태에서는 Item들에 접근할 수도 복호화할 수도 없습니다. 또한 풀린 상태에서도 해당 Item을 생성하고 저장한 어플리케이션에서만 접근이 가능합니다.

 하지만 지정된 그룹에 속한 어플리케이션끼리는 데이터에 접근할 수 있습니다.

 Keychain Items
 민감한 정보를 저장할 때 해당 데이터를 Keychain Item으로 패키징합니다. 이렇게 패키징된 Item안에는 저장하려는 데이터뿐만 아니라 해당 데이터의 속성(Attributes)또한 같이 저장됩니다. 이 속성으로는 데이터의 접근 가능성을 제어하고 해당 Item이 검색에 노출되게끔 공개적으로 보여주는 속성입니다.

 그리고 추후에 검증된 프로세스가 Item에 접근할 때 속성의 검색을 통해 해당 데이터를 찾고 접근할 수 있습니다.

 Keychain Wrappers
 기본적으로 제공되는 Keychain Services API도 존재하지만 이를 보다 편하고 안전하게 이용할 수 있게끔 해주는 라이브러리들이 존재합니다. 대표적인 라이브러리들은 다음과 같습니다.
 1. SwiftKeychainWrapper
 2. SAMKeychain - (Obj - c)
 3. LockSmith

 SwiftKeychainWrapper
 - add a string value to keychain
 let saveSuccessful: Bool = KeychainWrapper.standard.set(“Some String”, forKey: “myKey”)

 - retrieve a string value from keychain
 let retrievedString: String? = KeychainWrapper.standard.string(forKey: “myKey”)

 - remove a string value from keychain
 let removeSuccessful: Bool = KeychainWrapper.standard.remove(key: “myKey”)

 keychain을 사용할 때 :
 - 민감한 비밀번호나 인증서를 저장할 때 사용한다.
 - 보안성 👍
 - iOS 장치 상에서 암호화 정보를 저장하기 위해 keychain 사용
 */

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
