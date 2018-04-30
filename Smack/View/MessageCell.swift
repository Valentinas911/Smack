//
//  MessageCell.swift
//  Smack
//
//  Created by Valentinas Mirosnicenko on 4/30/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var userImage: CircleImage!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: Message) {
        messageLabel.text = message.message
        userNameLabel.text = message.userName
        userImage.image = UIImage(named: message.userAvatar)
        userImage.backgroundColor = UserDataService.instance.returnUIColor(components: message.userAvatarColor)
    }

}
