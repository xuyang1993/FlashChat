//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

import Firebase

import FirebaseAuth

import FirebaseDatabase


class ChatViewController: UIViewController {
    
    // Declare instance variables here
    var messageArray : [Message] = [Message]()
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO: Set yourself as the delegate and datasource here:
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        messageTableView.separatorStyle = .none
        
        //TODO: Set yourself as the delegate of the text field here:
        messageTextfield.delegate = self
        
        
        //TODO: Set the tapGesture here:
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)

        //TODO: Register your MessageCell.xib file here:
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "CustomMessageCell")
        messageTableView.register(UINib(nibName: "MessageCellTwo", bundle: nil), forCellReuseIdentifier: "UserMessageCell")
        
        configureTableView()
        retrieveMessages()
    }

    
    

    
    ///////////////////////////////////////////
    
    
    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        
        messageTextfield.endEditing(true)
        
        //TODO: Send the message to Firebase and save it in our database
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
        
        // Init Message Database
        let messageDB = Database.database().reference().child("Messages")
        
        // Format Message
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody": messageTextfield.text!]
        
        // Send Message
        messageDB.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                
                self.messageTextfield.text = ""
                
                self.messageTextfield.isEnabled = true
                self.sendButton.isEnabled = true
                
            }
            
        }
        
    }
    
    
    //TODO: Create the retrieveMessages method here:
    func retrieveMessages() {
        
        let messageDB = Database.database().reference().child("Messages")
        
        messageDB.observe(.childAdded, with: { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            
            let message = Message(sender: snapshotValue["Sender"]!, messageBody: snapshotValue["MessageBody"]!)
            
            self.messageArray.append(message)
            
            self.configureTableView()
            self.messageTableView.reloadData()
            
        })
        
    }
    
    
    //TODO: Declare tableViewTapped here:
    @objc func tableViewTapped() {
        messageTextfield.endEditing(true)
    }
    
    
    //TODO: Declare configureTableView here:
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120.0
    }
    
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        
        //TODO: Log out the user and send them back to WelcomeViewController
        
        do {
            try Auth.auth().signOut()
            
            self.navigationController?.popToRootViewController(animated: true)
            
        } catch {
            print("error, there was a problem when sign out")
        }
        
    }
    


}

///////////////////////////////////////////

//MARK:- TextField Delegate Methods
//TODO: Declare textFieldDidBeginEditing here:
//TODO: Declare textFieldDidEndEditing here:

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5, animations: {
            // iPhone X -25.0 safe area
            self.heightConstraint.constant = 50.0 + 333.0 - 25.0
            // iPhone 678+
            //self.heightConstraint.constant = 50.0 + 258.0
            self.view.layoutIfNeeded()
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.heightConstraint.constant = 50.0
            self.view.layoutIfNeeded()
        })
    }
    
}





///////////////////////////////////////////

//MARK: - TableView DataSource Methods
//TODO: Declare cellForRowAtIndexPath here:
//TODO: Declare numberOfRowsInSection here:

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.configureTableView()
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.messageArray[indexPath.row].sender == Auth.auth().currentUser?.email as String? {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserMessageCell", for: indexPath) as! UserMessageCell
            
            cell.messageBody?.text = self.messageArray[indexPath.row].messageBody
            cell.senderUsername.text = self.messageArray[indexPath.row].sender
            cell.avatarImageView?.image = UIImage(named: "egg")
            
            cell.messageBackground.backgroundColor = UIColor(red: 96/255, green: 163/255, blue: 188/255, alpha: 1.0)
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMessageCell", for: indexPath) as! CustomMessageCell
            
            cell.messageBody?.text = self.messageArray[indexPath.row].messageBody
            cell.senderUsername.text = self.messageArray[indexPath.row].sender
            cell.avatarImageView?.image = UIImage(named: "egg")
            
            cell.messageBackground.backgroundColor = UIColor(red: 7/255, green: 153/255, blue: 146/255, alpha: 1.0)
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}




