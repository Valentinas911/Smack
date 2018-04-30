//
//  ChatVC.swift
//  Smack
//
//  Created by Valentinas Mirosnicenko on 1/30/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.userDataDidChange), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatVC.selectChannel), name: NOTIF_CHANNEL_SELECTED, object: nil)
        
        if AuthService.instance.isLoggedIn {
            AuthService.instance.findUserByEmail { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            }
        }
        
    }
    
    @objc func selectChannel(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? "Channel Not Found"
        channelNameLabel.text = "#\(channelName)"
    }

    @objc func userDataDidChange() {
        if AuthService.instance.isLoggedIn {
            // Get Channels
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log In"
        }
    }

    func onLoginGetMessages() {
        MessageService.instance.findAllChannel { (success) in
            if success {
                // Do stuff with channels
            }
        }
    }


}
