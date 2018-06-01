//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit

import Firebase

import FirebaseAuth

import SVProgressHUD


class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Demo
        //emailTextfield.text = "xuyang@xy.com"
        //passwordTextfield.text = "123456"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {

        SVProgressHUD.show()
        
        //TODO: Log in the user
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!) { (user, error) in
            
            if error != nil {
                
                let alert = UIAlertController(title: "Registration Failed", message: "\(error!)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
            
            SVProgressHUD.dismiss()
        }
    }
    


    
}  
