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

    var managedContext: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard save(name: "Entity") else {
            return
        }
        
        guard let result = fetch() else {
            return
        }
        
        for element in result {
            guard let name = element.value(forKey: "name") else {
                continue
            }
            
            print("people = \(name)")
        }
    }
    
    func fetch() -> [NSManagedObject]? {
        guard let managedContext = managedContext else {
            return nil
        }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
        
        do {
            return try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("error : \(error)")
        }
        
        return nil
    }
    
    func save(name: String) -> Bool {
        guard let managedContext = managedContext else {
            return false
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Entity", in: managedContext) else {
            return false
        }
        
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKey: "name")
        
        do {
            try managedContext.save()
            return true
        } catch let error as NSError {
            print("error: \(error)")
        }
        
        return false
    }
}
