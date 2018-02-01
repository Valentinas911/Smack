//
//  CreateAccountVC.swift
//  Smack
//
//  Created by Valentinas Mirosnicenko on 2/1/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: Segue.unwindToChannel, sender: nil)
    }
    

}
