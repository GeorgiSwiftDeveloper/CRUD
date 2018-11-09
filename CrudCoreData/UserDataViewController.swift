//
//  UserDataViewController.swift
//  CrudCoreData
//
//  Created by Georgi Malkhasyan on 10/15/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import CoreData

class UserDataCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var last: UILabel!
    
    @IBOutlet weak var email: UILabel!
    
    @IBOutlet weak var phone: UILabel!
}

class UserDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

    var userArray = NSMutableArray()
    
    @IBOutlet weak var userTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        // Do any additional setup after loading the view.
    }
    
    //MARK: FetchRequest entity Result
    func request () {
        let contex = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let req = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        req.returnsObjectsAsFaults = false
        do{
            let result = try? contex?.fetch(req)
            for data in result as! [NSManagedObject] {
                userArray.add(data)
            }
            userTableView.delegate = self
            userTableView.dataSource = self
            userTableView.reloadData()
        }
        catch{
            print("failed")
        }
    }
    
    //MARK: TableView Delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userTableView.dequeueReusableCell(withIdentifier: "UserDataCell", for: indexPath) as! UserDataCell
        cell.name.text = (userArray[indexPath.row] as AnyObject).value(forKey: "name") as! String
         cell.last.text = (userArray[indexPath.row] as AnyObject).value(forKey: "lastname") as! String
         cell.email.text = (userArray[indexPath.row] as AnyObject).value(forKey: "email") as! String
         cell.phone.text = (userArray[indexPath.row] as AnyObject).value(forKey: "phone") as! String
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    //MARK: Delete UITableViewRow
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
           
             let contex = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            
            contex?.delete(self.userArray[indexPath.row] as! NSManagedObject)
            
            do{
                try? contex?.save()
                self.userArray.removeAllObjects()
                self.request()
            }
        }
    }

}
