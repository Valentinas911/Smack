//
//  ProfileVC.swift
//  Smack
//
//  Created by Valentinas Mirosnicenko on 4/30/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameTxt: UILabel!
    @IBOutlet weak var emailTxt: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        UserDataService.instance.logoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        profileImg.image = UIImage(named: UserDataService.instance.avatarName)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        usernameTxt.text = UserDataService.instance.name
        emailTxt.text = UserDataService.instance.email
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.dismissVC(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissVC(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
}
