//
//  Book.swift
//  LabTest1Sam
//
//  Created by MacStudent on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Details: UIViewController {
    
    //label outlets
//
//    @IBOutlet weak var label1: UILabel!
//    @IBOutlet weak var label2: UILabel!
//    @IBOutlet weak var label3: UILabel!
//    @IBOutlet weak var label4: UILabel!
//
    @IBOutlet weak var stName: UITextField!
    //TextFileds outlet
    @IBOutlet weak var stAge: UITextField!
    
    @IBOutlet weak var stDate: UITextField!
    @IBOutlet weak var stFees: UITextField!
    
    
    
    // context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var student:[NSManagedObjectContext] = []
     var managedContext: NSManagedObjectContext!
   
    override func viewDidLoad()
    {
    super.viewDidLoad()
    }
//    @IBAction func updateBtn(_ sender: Any)
//
//    {
//        let alert = UIAlertController(title: "Update Student Details",
//                                             message: "", preferredStyle: .alert)
//               let saveAction = UIAlertAction(title: "Save",  style: .default) {
//                   [unowned self] action in
//
//                   guard let textField = alert.textFields?.first,
//
//                       let nameToSave = textField.text else {
//                       return
//                   }
//                guard let textField1 = alert.textFields?.first, let ageToSave = textField1.text else
//                { return }
//
//                   //age city graduate name
//                  // let dataList = nameToSave.components(separatedBy: ",")
//
////                   if dataList.count == 4 {
////                       let age: Int = Int(dataList[0]) ?? 0
////                       let city : String = dataList[1]
////                       let graduate: Bool = Bool(dataList[2] ) ?? false
////                       let name: String = dataList[3]
////
//                       //self.names.append(nameToSave)
//
////                       self.tableView.reloadData()
////                   }else{
////                       print("error data input")
//                   }
//
//
//            alert.addTextField()
//        alert.addTextField()
//               alert.addAction(saveAction)
//               //alert.addAction(cancelAction)
//        present(alert, animated: true)}

    @IBAction func saveBtn(_ sender: Any) {
    
    
//      //  save()
             let nameToSave = stName.text
               let ageToSave = stAge.text
               let tuitionToSave = stFees.text
               let dateToSave = stDate.text

               let dateFormatter = DateFormatter()
               dateFormatter.dateStyle = .short
               dateFormatter.timeStyle = .none

        self.save(name: nameToSave!,age : Int32(ageToSave!)!, tuition : Double(tuitionToSave!)!, date : dateFormatter.date(from: dateToSave!)!)

        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
   func save(name: String, age : Int32, tuition : Double, date : Date)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
        let entity = NSEntityDescription.entity(forEntityName: "Student", in: managedContext)!
    let students = NSManagedObject(entity: entity,insertInto: managedContext)

        
    students.setValue(age, forKey: "age")
    students.setValue(date, forKey: "date")
    students.setValue(name, forKey: "name")
    students.setValue(tuition, forKey: "tution")
        
        
        do {
                try managedContext.save()
    
            }
            catch let error as NSError {
                print(error)
            }
    }
   
}
