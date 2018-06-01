//
//  Message.swift
//  Flash Chat
//
//  This is the model class that represents the blueprint for a message

import Foundation

class Message: NSObject {
    
    //TODO: Messages need a messageBody and a sender variable
    
    var sender: String = ""
    var messageBody: String = ""
    
    override init() {
        super.init()
    }
    
    init(sender: String, messageBody: String) {
        self.sender = sender
        self.messageBody = messageBody
    }
    
}
