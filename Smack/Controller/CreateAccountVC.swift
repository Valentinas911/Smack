//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Valentinas Mirosnicenko on 2/1/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTxt.delegate = self
        passwordTxt.delegate = self
        emailTxt.delegate = self
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: Segue.unwindToChannel, sender: nil)
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        guard let email = emailTxt.text, emailTxt.text != "" else { return }
        guard let password = passwordTxt.text, passwordTxt.text != "" else { return }
        
        AuthService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("Registered User")
            }
        }
        
    }
    
    @IBAction func pickAvatarPressed(_ sender: Any) {
        
    }
    
    @IBAction func generateColorPressed(_ sender: Any) {
        
    }
    

}

extension CreateAccountVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    
    
}
