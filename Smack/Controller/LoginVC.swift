//
//  LoginVC.swift
//  Smack
//
//  Created by Valentinas Mirosnicenko on 2/1/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Segue.toCreateAccount, sender: nil)
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        spinner.startAnimating()
        
        guard let email = usernameTxt.text, usernameTxt.text != "" else { return }
        guard let password = passwordTxt.text, passwordTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                debugPrint("User Logged In")
                AuthService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        debugPrint("User information Fetched")
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.spinner.stopAnimating()
                        return
                    }
                })
            } else {
                self.spinner.stopAnimating()
                return
            }
        }
        
    }
    
    func setupView() {
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
        
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor:smackPurplePlaceholder])
        spinner.hidesWhenStopped = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginVC.handleTap))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        view.endEditing(true)
    }
    
    
    
}
