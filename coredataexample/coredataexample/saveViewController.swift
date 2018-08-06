//
//  saveViewController.swift
//  coredataexample
//
//  Created by Elluminati Mac Mini 1 on 05/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import CoreData
class saveViewController: UIViewController {
    
    let appdel = AppDelegate()
    var isEdit : Bool = false
    var object : StudentDetails!
    var resultData : [StudentDetails] = []
    var flag = Bool()
    var msg = String()
    @IBOutlet weak var name_textfield: UITextField!
    
    var stds:StudentDetails!
    
    @IBOutlet weak var marks_textfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(isEdit)
        {
            name_textfield.text = stds.studentName;
            marks_textfield.text = stds.studentMark;
            
            
            
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backbutton(_ sender: Any) {
        self.performSegue(withIdentifier: "listview", sender: self)
    }
    @IBAction func saveAction(_ sender: Any) {
        
        if isEdit == false {
            self.save(name: name_textfield.text!, mark: marks_textfield.text!)
        }
        else{
        self.updateStudentData()
       }
        
    }
    func save(name: String, mark : String) {
        
        if isEdit == false{
            
            let student = NSEntityDescription.insertNewObject(forEntityName: "StudentDetails", into: DataBaseController.persistentContainer.viewContext) as! StudentDetails
            
            student.studentName = self.name_textfield.text!
            student.studentMark  = self.marks_textfield.text!
       
            do {
                try appdel.saveContext()
                
                flag = true
                
                self.alert(title:"save" ,msge:"successfully",flag: true)
            } catch let error as NSError {
                flag = false
                msg = " not successfully"
                self.alert(title:"save",msge:" not successfully",flag: false)
                
                print("Could not save. \(error), \(error.userInfo)")
        }
        }
        else if isEdit == true {
            self.updateStudentData()
        }
        
        
         }
    func alert(title:String,msge:String,flag:Bool){
        
            let alertController = UIAlertController.init(title:title, message: msge, preferredStyle: .alert)
       
            let alertAction = UIAlertAction.init(title: "OK", style: .default) { (UIAlertAction) in
               if flag == true {
                self.performSegue(withIdentifier: "listview", sender: self)
               }
               else{
                self.dismiss(animated: true, completion: nil)
                }

        }
                alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
   
     self.fetchdata()
    }
 
    func fetchdata(){
        
     
       
    }
    func updateStudentData(){
        
        
        let FetchReq:NSFetchRequest<NSFetchRequestResult>
        FetchReq = NSFetchRequest.init(entityName: "StudentDetails" as String)
        FetchReq.entity = NSEntityDescription.entity(forEntityName:"StudentDetails" as String, in: DataBaseController.persistentContainer.viewContext)
        let predicate = NSPredicate.init(format: "studentName == %@", stds.studentName as! CVarArg)
        FetchReq.predicate = predicate
        do {
            
            let results = try DataBaseController.persistentContainer.viewContext.fetch(FetchReq)
            
            
            let dictTemp:NSMutableDictionary = NSMutableDictionary.init()
            
            dictTemp.setValue(name_textfield.text!, forKey: "studentName");
            dictTemp.setValue(marks_textfield.text!, forKey: "studentMark");
            
            let arrTemp:NSMutableArray = NSMutableArray.init()
            arrTemp.add(dictTemp)
            
            for insertData in results {
                for i:NSInteger in 0 ..< arrTemp.count {
                    let objectRecord:NSDictionary = arrTemp.object(at: i) as! NSDictionary
                    for key in objectRecord.allKeys {
                        (insertData as AnyObject).setValue(objectRecord.value(forKey: key as! String), forKey: key as! String)
                    }
                }
            }
   
        do {
            try DataBaseController.saveContext()
       
            flag = true
            
            self.alert(title:"update",msge:"successfully",flag: true)
        } catch let error as NSError {
            flag = false
            msg = " not successfully"
            self.alert(title:"update",msge:" not successfully",flag: false)
            
            print("Could not save. \(error), \(error.userInfo)")
        }
            
        } catch  {
            fatalError("Failed to fetch employees: \(error)")
        }
        

    }
}


