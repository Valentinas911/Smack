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
    @IBOutlet weak var messageTxtBox: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatVC.handleTap))
        view.addGestureRecognizer(tap)
        
        
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
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        
        if AuthService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?._id else { return }
            guard let message = messageTxtBox.text else { return }
            SocketService.instance.addMessage(messageBody: message, userId: UserDataService.instance.id, channelId: channelId) { (success) in
                if success {
                    self.messageTxtBox.text = ""
                    self.messageTxtBox.resignFirstResponder()
                }
            }
            
            
            
            
        }
        
        
        view.endEditing(true)
    }
    
    @objc func selectChannel(_ notif: Notification) {
        updateWithChannel()
    }
    
    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? "Channel Not Found"
        channelNameLabel.text = "#\(channelName)"
        getMessages()
    }

    @objc func handleTap() {
        view.endEditing(true)
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
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels.first
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No Channels Yet"
                }
            }
        }
    }
    
    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
    }

}

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
}
