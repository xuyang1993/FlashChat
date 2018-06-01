//
//  NewTableViewCell.swift
//  Flash Chat
//
//  Created by soar on 25/5/18.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit

class UserMessageCell: UITableViewCell {

    
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var messageBody: UILabel!
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code goes here
        
        
        
    }
    

}
