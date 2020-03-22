//
//  MessageCell.swift
//  flashChat
//
//  Created by Sebastian Malm on 3/18/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // MARK: - Properties
    
    var cellType = CellType.me { didSet {
        if cellType == .me {
            meAvatar.isHidden = false
            youAvatar.isHidden = true
            messageView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        } else {
            meAvatar.isHidden = true
            youAvatar.isHidden = false
            messageView.backgroundColor = UIColor(named: K.BrandColors.purple)
            messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        }}
    
    @IBOutlet weak var messageView: UIView! {
        didSet { messageView.layer.cornerRadius = messageView.frame.height / 5 }
    }
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var meAvatar: UIImageView!
    @IBOutlet weak var youAvatar: UIImageView!
}

enum CellType {
    case me
    case you
}
