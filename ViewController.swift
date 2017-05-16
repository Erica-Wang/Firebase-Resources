//
//  ViewController.swift
//  Firebase login
//
//  Created by Moyang Erica Wang on 2016-12-29.
//  Copyright © 2016 Moyang Erica Wang. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var nameTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = FIRAuth.auth()?.currentUser{
            self.logoutButton.alpha = 1.0
            self.lbl.text = user.email
        }
        else{
            self.logoutButton.alpha = 0.0
            self.lbl.text = ""
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createAction(_ sender: Any) {
        
        if self.emailTxt.text == "" || self.passwordTxt.text == ""{
            
            let alertController = UIAlertController(title: "Oops", message: "Please enter an email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            
            FIRAuth.auth()?.createUser(withEmail: self.emailTxt.text!, password: self.passwordTxt.text!, completion: { (user, error) in
                
                
                if error == nil{
                    
                    self.logoutButton.alpha = 1.0
                    self.lbl.text = user?.email
                    self.emailTxt.text = ""
                    self.passwordTxt.text = ""
                    
                }
                else{
                    
                    let alertController = UIAlertController(title: "Oops", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            
            
            })
            
        }
        
    }

    @IBAction func loginAction(_ sender: Any) {
        
        if self.emailTxt.text == "" || self.passwordTxt.text == ""{
            
            let alertController = UIAlertController(title: "Oops", message: "Please enter an email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }
        else{
            FIRAuth.auth()?.signIn(withEmail: self.emailTxt.text!, password: self.passwordTxt.text!, completion: { (user, error) in
                
                
                if error == nil{
                    
                    self.logoutButton.alpha = 1.0
                    self.lbl.text = user?.email
                    self.emailTxt.text = ""
                    self.passwordTxt.text = ""
                    
                }
                else{
                    
                    let alertController = UIAlertController(title: "Oops", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                }
                
                
            })
         }
        
    }
    @IBAction func logoutAction(_ sender: Any) {
        
        try! FIRAuth.auth()?.signOut()
        
        self.lbl.text = ""
        self.logoutButton.alpha = 0.0
        self.emailTxt.text = ""
        self.passwordTxt.text = ""
        
    }

}
















