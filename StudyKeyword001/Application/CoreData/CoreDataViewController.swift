//
//  CoreDataViewController.swift
//  StudyKeyword001
//
//  Created by Webcash on 2020/02/10.
//  Copyright © 2020 Moonift. All rights reserved.
//

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
        
        var index = 0
        for element in result {
            guard let name = element.value(forKey: "name") else {
                continue
            }
            
            self.objects.insert(name as! String, at: index)
            
            print("object(\(index)) = \(name)")
            index -= -1
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
    private var managedContext: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
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
    
    private func fetchData(_ objectName: String) -> [NSManagedObject]? {
        guard let managedContext = managedContext else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: objectName)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            return result
        } catch let error as NSError {
            print("error: \(error)")
        }
        
        return nil
    }
    
    private func insertData(_ objectName: String) {
        guard let managedContext = managedContext else {
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Entity", in: managedContext) else {
            print("not found entity name: Entity")
            return
        }
        
        let object = NSManagedObject(entity: entity, insertInto: managedContext)
        object.setValue(objectName, forKey: "name")
        
        print("insert data was successful 😃")
        
        guard saveData() else {
            return
        }
    }
    
    private func deleteObject(_ objectName: String) {
        guard let managedContext = managedContext else {
            return
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        
        guard let result = try? managedContext.fetch(fetchRequest) else {
            print("result is nil")
            return
        }
        
        for element in result {
            if element.value(forKey: "name") as! String == objectName {
                managedContext.delete(element)
            }
        }
        
        print("\(objectName) was deleted successful 😃")
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
