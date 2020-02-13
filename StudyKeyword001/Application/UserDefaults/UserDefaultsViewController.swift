//
//  UserDefaultsViewController.swift
//  StudyKeyword001
//
//  Created by Webcash on 2020/02/10.
//  Copyright © 2020 Moonift. All rights reserved.
//

/*
 UserDefault
 
 -  데이터 저장소

 UserDefaults는 사용자 기본 설정과 같은 단일 데이터 값에 적합하다.

 그래서 대량의 유사한 데이터(테이블에 대한 레코드, 여러 사용자에 대한 데이터 등)를 저장해야하는 경우에는 sqlite 데이터베이스가 더 적합하다.

 UserDefaults는 [데이터, 키(key)]으로 데이터를 저장한다.
 이때 key값은 String이다.

 대체로 standard라는 이름의 싱글톤을 이용해 데이터에 액세스하기 때문에 인스턴스를 생성할 필요가 없다.

 값을 저장할 때 :
 UserDefaults.standard.set(value, forKey: ‘Some Key Name”)
 UserDefaults.synchronize()

 synchronize() 메소드는 UserDefaults에 기록된 값을 파일에쓰는 역할을 한다.
 따라서 여러 값을 변경할 경우 매번 synchronize()를 호출할 필요 없이 다 쓰고 난 다음에 마지막에 딱 한번만 synchronize()를 호출하면 된다.

 호출하지 않아도 특정 인터벌이나 클래스 deinit 시를 기준으로 synchronize() 알아서 호출한다.

 nil을 넣어버리면 해당 데이터를 지우는 것과 동일하다.

 저장한 값을 읽어올 때:
 let value = UserDefaults.standard.object(forKey: “Some Key Name”) as? String

 object로 가져오면 타입을 확실하게 바꿔주어야 할 것이고
 or
 let value = UserDefaults.standard.string(forKey: “Some Key Name”)
 처럼 타입을 명확하게 해서 읽어올 수도 있다.

 읽기 시에는 저장된 값이 없을수도 있어서 읽기 메소드는 모두 옵셔널을 리턴한다.
 반대로 이를 이용해 기본값을 제공하는 방법도 있다.

 vara userName: String {
     return UserDefaults.standard.string(forKey: “User Name”) ?? “Noname”
 }

 프로퍼티 getter를 이런 식으로 구현하는 것도 가능하다.


 */

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var userNameLb: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userNameLb.text = UserDefaults.standard.string(forKey: "userName") ?? "Unknown User"
    }

    @IBAction func gotoSettingsScreen(_ sender: UIButton) {
        self.navigationController?.pushViewController(self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController, animated: true)
    }
    
}
