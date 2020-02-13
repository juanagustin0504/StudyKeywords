//
//  CoreDataViewController.swift
//  StudyKeyword001
//
//  Created by Webcash on 2020/02/10.
//  Copyright © 2020 Moonift. All rights reserved.
//

/*
 CoreData

 1. 기본 개념

 - 코어데이터의 뿌리는 NeXT의 엔터프라이즈 객체 프레임워크 (EOF) 에서 찾을 수 있다.
 이 프레임워크는 객체를 관계형 데이터베이스로 매핑할 수 있다.

 관계형 데이터베이스를 사용하면
 데이터베이스에 종속적인 로직을 구현하는 대신
 비지니스 로직을 객체에 구현하게 되므로 적은 양의 코드로 같은 기능을 구현할 수 있다.
 이를 통해 DB 요구사항보다 앱의 요구하상을 구현하는 데 더 집중할 수 있다.

 코어데이터는 애초에 Mac OS X 상에서 단일 사용자를 지원하도록 만들어졌고,
 내장 관계형 데이터베이스인 SQLite 에 데이터를 저장한다.

 코어 데이터는 다음과 같은 기능을 포함한다.
 - 시각적인 모델 편집기를 통해 데이터 객체를 모델링한다.
 - 객체의 스키마가 변경될 경우 마이그레이션 도구를 이용해 처리한다.
 - 일대일, 일대다, 다대다의 객체 간 관계를 생성할 수 있다.
 - 별도의 파일이나 여러 파일 포맷으로 데이터를 저장할 수 있다.
 - 객체 속성을 검증한다.
 - 데이터 질의와 정렬이 가능하다.
 - 데이터는 지연로딩된다.
 - iOS TableView와 연동해 동작할 수 있다. (NSFetchedResultsCcontroller)
 - 저장과 되돌리기 기능으로 관계 객체 변화를 관리할 수 있다.

 2. 데이터 저장 방식 비교

 1) NSUserDefaults
   : 앱의 Preference를 저장할 때 주로 사용한다.

 2) plist
   : XML 파일 포맷으로 앱의 지속적인 정보의 요구사항을 Dictionary나 Array로 충족시킬 수 있다면 plist를 이용하면 된다.

 3) SQLite 직접 이용
   : C로 작성된 libsqlite 라이브러리를 이용하면 앱에서 SQLite 데이터베이스에 직접 접근할 수 있다.
   SQLite는 내장 관계형 데이터베이스로 서버를 필요로 하지 않고 SQL 언어의 대부분의 기능을 지원한다.
   단점은 앱 스스로 애플리케이션의 데이터베이스 객체와 SQL 파일 간의 관계를 직접 매핑해야한다는 점이다.
   이 경우 데이터를 가져오거나 저장하는 SQL 질의문 등을 직접 작성해야하며
   현재 어떤 객체들을 저장해야 하는지 추적하는 코드도 직접 만들어야 한다.

 4) CoreData
   : SQLite에 직접 접근하는 방식만큼 유연함을 제공하면서도
   앱과 데이터베이스의 동작 방식을 분리해준다.
   앱이 많은 데이터를 필요로 하고 여러 다른 객체 간의 관계를 관리해야 하며
   특정 객체나 객체의 그룹에 빠르고 쉽게 접근해야한다면 CoreData를 사용하는 것이 좋다.

 3. 작동 방식

 1) NSPersistentStore (영구 저장소)

 데이터를 저장하는 파일을 나타낸다.
 앱에서 코어데이터를 이용하도록 설정할 때 영구 저장소의 이름, 위치, 타입을 지정해야한다.

 2) NSPersistentStoreCoordinator (영구 저장소 관리자)

 객체의 데이터를 실제로 저장하고 이는 실제 파일 (NSPersistentStore) 과
 앱이 사용하는 객체 모델 사이를 중개한다.
 앱은 NSPersistentStoreCoordinator에 직접 접근할 일이 거의 없다.
 단지 코어 데이터 실행 환경을 구성할 관리자 객체를 생성만 해주면 된다.
 NSPersistentStoreCoordinator는 하나 이상의 영구 저장소와의 통신을 관리하기 때문에
 데이터가 어떻게 저장되는지를 앱으로부터 감춘다.

 3) NSManagedObjectContext (관리 객체 컨텍스트)

 관리 객체가 존재하는 영역이다.
 앱에서는 관리 객체의 생성, 삭제, 편집, 질의 등을 수행하기 위해 NSManagedObjectContext와 통신한다.
 NSManagedObjectContext는 객체들의 변경사항을 관리하며
 모든 변경사항을 한꺼번에 저장하거나 경우에 따라서는 rollback한다.
 전체 데이터 작업을 분리하거나 제한하기 위해 하나 이상의 context를 동시에 사용할 수 있다.

 4) NSManagedObjectModel (관리 객체 모델)

 관리 객체는 관리 객체 모델 (NSManagedObjectModel)에서 정의한다.
 NSManagedObjectModel은 객체(Entity)의 리스트, 각 개채와 연결된 속성 리스트(properties),
 각 개체 및 속성과 연결된 유효성 검증, 개채 간의 관계를 포함한다.
 관리 객체 모델은 주로 XCode의 데이터 모델 편집기를 이용해 생성한다.

 5) NSManagedObject (관리 객체)

 코어데이터 상에서 실제 정보를 담고있는 객체를 의미한다.
 관리 객체를 키와 그 키에 대응하는 타입의 객체를 가진 Dictionary 객체처럼 생각할 수 있다.

 6) 추가 기능 (NSFetchedResultsController)

 Fetch 요정의 결과와 테이블 뷰를 손쉽게 연결시켜 준다.
 이 컨트롤러는 Fetch 결과를 섹션과 줄 단위로 리턴하도록 설정할 수 있고,
 인덱스를 이용해 접근할 수 있다.
 테이블 뷰를 구현할 때 필요한 정보를 얻을 수 있는 메소드도 제공하며,
 코어데이터에서 변경 이벤트가 발생하면 이를 감지한 후 delegate 메소드를 이용해 테이블에 반영할 수 있다.

 */

import UIKit
import CoreData

class CoreDataViewController: UIViewController {
    
    //MARK: - outlet -
    @IBOutlet weak var objectName: UITextField!
    
    @IBOutlet weak var resultLb: UILabel!
    
    @IBOutlet weak var showObjectBtn: UIButton!
    @IBOutlet weak var insertObjectBtn: UIButton!
    @IBOutlet weak var deleteObjectBtn: UIButton!
    
    //MARK: - properties -
    private var objects: [String] = [String]()
    
    private var managedContext: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
    //MARK: - life cycle -
    override func viewDidLoad() {
        self.objectName.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.insertObjectBtn.isEnabled = false
        self.deleteObjectBtn.isEnabled = false
    }
    
    
    //MARK: - action -
    @IBAction func showObjectsButtonTapped(_ sender: UIButton) {
        guard let result = fetchData("Entity") else {
            return
        }
        
        if result.isEmpty {
            alert(title: "Empty", message: "CoreData is Empty")
            return
        }
        
        var index = 0
        for element in result {
            guard let name = element.value(forKey: "name") else {
                continue
            }
            
            self.objects.insert(name as! String, at: index)
            
            print("object(\(index)) = \(name)")
            index -= -1 // XD
        }
        
        var msg = ""
        for i in 0 ..< objects.count {
            msg += objects[i] + "\n"
        }
        
        let alert = UIAlertController(title: "Entity", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(alertAction)
        
        self.present(alert, animated: true)
        
        objects.removeAll()
    }
    
    @IBAction func insertObjectButtonTapped(_ sender: UIButton) {
        self.insertData(self.objectName.text!)
        self.resultLb.text = "Insert data was successful 😃"
    }
    
    @IBAction func deleteObjectButtonTapped(_ sender: UIButton) {
        self.deleteObject(self.objectName.text!)
        self.resultLb.text = "Delete data was successful 😃"
    }
    
    //MARK: - custom method -
    private func saveData() -> Bool {
        
        guard let managedContext = managedContext else {
            return false
        }
        
        do {
            try managedContext.save()
            
            return true
        } catch let error as NSError {
            print("error : \(error)")
        }
        
        return false
    }
    
    private func fetchData(_ entityName: String) -> [NSManagedObject]? {
        guard let managedContext = managedContext else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result
        } catch let error as NSError {
            print("error: \(error)")
        }
        
        return nil
    }
    
    private func insertData(_ nameValue: String) {
        guard let managedContext = managedContext else {
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Entity", in: managedContext) else {
            print("not found entity name: Entity")
            return
        }
        
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        object.setValue(nameValue, forKey: "name")
        
        print("insert data was successful 😃")
        
        guard saveData() else {
            return
        }
    }
    
    private func deleteObject(_ nameValue: String) {
        guard let managedContext = managedContext else {
            return
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        
        guard let result = try? managedContext.fetch(fetchRequest) else {
            print("result is nil")
            return
        }
        
        for element in result {
            if element.value(forKey: "name") as! String == nameValue {
                managedContext.delete(element)
            }
        }
        
        print("\(nameValue) was deleted successful 😃")
        guard saveData() else {
            return
        }
    }
    
}

//MARK: - extension -
extension CoreDataViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string) as NSString
        if  newString != ""{
            self.insertObjectBtn.isEnabled = true
            self.deleteObjectBtn.isEnabled = true
        } else {
            self.insertObjectBtn.isEnabled = false
            self.deleteObjectBtn.isEnabled = false
        }
        return true
    }
}
