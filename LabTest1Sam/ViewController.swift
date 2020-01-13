//
//  ViewController.swift
//  LabTest1Sam
//
//  Created by MacStudent on 2020-01-08.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    //outlet for tableview
    @IBOutlet weak var tableView: UITableView!

    //array of book names
   var studentDetails:[Student] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //title student dia details
        title = "Students Data"
        //register karna table nu te cell nu register class de nal
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    
    }
    
    func fetchData(){
       
          let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do{
            studentDetails = try context.fetch(Student.fetchRequest())
        }
            //if error exists/catch it
        catch{
            print(error)
        }
    }
   
}


// extend wala controller
extension ViewController:UITableViewDataSource
{
    //dasda kinia rows ne ik particular section ch
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = studentDetails[indexPath.row]
        
        let dateFormatter = DateFormatter()
           dateFormatter.dateStyle = .short
           dateFormatter.timeStyle = .none
        
        let value = studentDetails[indexPath.row]
        cell.textLabel!.text = value.name! 

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         
        if editingStyle == .delete{
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let person = studentDetails[indexPath.row]
            context.delete(person)

                do {
                        try context.save()
            
                    }
                    catch let error as NSError {
                        print(error)
                    }
            
            fetchData()
            tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let std = studentDetails[indexPath.row]
    
    if let viewController = storyboard?.instantiateViewController(identifier: "Details") as? Details {
        navigationController?.pushViewController(viewController, animated: true)
        print("hello")
    }
    }
}
