//
//  CircleImage.swift
//  Smack
//
//  Created by Valentinas Mirosnicenko on 4/30/18.
//  Copyright © 2018 Valentinas Mirosnicenko. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

    override func awakeFromNib() {
        setupViews()
    }
    
    override func prepareForInterfaceBuilder() {
        setupViews()
    }
    
    func setupViews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

}
