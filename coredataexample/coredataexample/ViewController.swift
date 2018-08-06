//
//  ViewController.swift
//  coredataexample
//
//  Created by Elluminati Mac Mini 1 on 05/04/18.
//  Copyright © 2018 Example. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let appdel = AppDelegate()
    var studentArray : [StudentDetails] = []
    @IBOutlet weak var tableview: UITableView!
      override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let std:NSFetchRequest<StudentDetails> = StudentDetails.fetchRequest()
        do{
            self.studentArray = try DataBaseController.persistentContainer.viewContext.fetch(std)
            print(studentArray)
            
        } catch{
            print(error.localizedDescription)
        }
         self.tableview.reloadData()
    }
    func datarefresh(){
        let std:NSFetchRequest<StudentDetails> = StudentDetails.fetchRequest()
        do{
            self.studentArray = try DataBaseController.persistentContainer.viewContext.fetch(std)
            print(studentArray)
            
        } catch{
            print(error.localizedDescription)
        }
        
        self.tableview.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return studentArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = self.tableview.dequeueReusableCell(withIdentifier: "listd") as! listTableViewCell
        
         let stdarrau = studentArray[indexPath.row]
        print(stdarrau)
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle,
                                   reuseIdentifier: "listd") as! listTableViewCell
        }
       
        
            cell.name.text! = "name : \(stdarrau.studentName!) \n mark : \(stdarrau.studentMark!)"
            
            cell.edit.tag = indexPath.row
            cell.delete.tag = indexPath.row
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let saveScreen = self.storyboard?.instantiateViewController(withIdentifier: "save")as! saveViewController
        saveScreen.stds = studentArray[indexPath.row]
        self.present(saveScreen, animated: true, completion: nil)
    }
    
  
    @IBAction func Delete(_ sender: Any) {
        
        let btnDelete : UIButton = sender as! UIButton
        let selectedIndex : Int = btnDelete.tag
       //studentArray[selectedIndex] as! StudentDetails
       
        let fetchRequest = NSFetchRequest<StudentDetails>(entityName: "StudentDetails")
        let predicate = NSPredicate(format: "studentName = %@",studentArray[selectedIndex].studentName as! CVarArg)
        fetchRequest.predicate = predicate
       
    let stdt = DataBaseController.persistentContainer.viewContext
        let result = try? stdt.fetch(fetchRequest)
        let resultData = result! as [StudentDetails]
        for object in resultData {
            stdt.delete(object)
        }
        do {
            try stdt.save()
            print("saved")
        }catch let error as NSError  {
                       print("Could not save \(error), \(error.userInfo)")
                    }
        self.datarefresh()
   }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "editSegue")
        {
            let btnEdit : UIButton = sender as! UIButton
            let selectedIndex : Int = btnEdit.tag
            let viewscreen : saveViewController = segue.destination as! saveViewController
            viewscreen.isEdit = true
            viewscreen.stds = studentArray[selectedIndex] as! StudentDetails

        }
    }
    
    
    @IBAction func saveName(segue: UIStoryboardSegue) {
        let saveController = segue.source as! saveViewController
        // Address.text = saveController.addressString
        
        
    }
}

