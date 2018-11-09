//
//  ViewController.swift
//  CrudCoreData
//
//  Created by Georgi Malkhasyan on 10/15/18.
//  Copyright © 2018 Adamyan. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITextFieldDelegate {

    
    
    
    @IBOutlet weak var nameTxt: UITextField!
    
    @IBOutlet weak var lastTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    
    @IBOutlet weak var phoneTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //MARK: Document directory
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        nameTxt.delegate = self
        lastTxt.delegate = self
        emailTxt.delegate = self
        phoneTxt.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        nameTxt.text = ""
        lastTxt.text = ""
        emailTxt.text = ""
        phoneTxt.text = ""
        
        nameTxt.becomeFirstResponder()
    }
    
    //MARK: TextField delegate for Responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameTxt {
            lastTxt.becomeFirstResponder()
        }else {
            lastTxt.resignFirstResponder()
        }
        if textField == lastTxt {
            emailTxt.becomeFirstResponder()
        }else {
            emailTxt.resignFirstResponder()
        }
        if textField == emailTxt {
            phoneTxt.becomeFirstResponder()
        }else {
            phoneTxt.resignFirstResponder()
        }
        return true
    }
    
    
    //MARK: Save data NSManagedObject 
    @IBAction func buttonSaveData(_ sender: UIButton) {
        if nameTxt.text == ""  {
            let alert = UIAlertController(title: "Check name Fild", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else if lastTxt.text == "" {
            let alert = UIAlertController(title: "Check lastname Fild", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else if emailTxt.text?.contains("@") == false || emailTxt.text?.contains(".") == false {
            let alert = UIAlertController(title: "Check email Fild", message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else if phoneTxt.text == "" {
            let alert = UIAlertController(title: "Check phone Fild", message: "Must contain 818-582-5533", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else {
        let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Users", in: context!)
        let newUser = NSManagedObject(entity: entity!, insertInto: context!)
        newUser.setValue(nameTxt.text, forKey: "name")
        newUser.setValue(lastTxt.text, forKey: "lastname")
        newUser.setValue(emailTxt.text, forKey: "email")
        newUser.setValue(phoneTxt.text, forKey: "phone")
        do{
            try? context?.save()
            let storybord = UIStoryboard(name: "Main", bundle: nil)
            let vc = storybord.instantiateViewController(withIdentifier: "UserDataViewController") as! UserDataViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }catch{
            print(error)
        }
    }
    }
    
}

