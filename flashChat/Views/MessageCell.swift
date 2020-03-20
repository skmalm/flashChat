//
//  MessageCell.swift
//  flashChat
//
//  Created by Sebastian Malm on 3/18/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Properties
    
    
    @IBOutlet weak var messageView: UIView! {
        didSet { messageView.layer.cornerRadius = messageView.frame.height / 5 }
    }
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var meAvatar: UIImageView!
    @IBOutlet weak var youAvatar: UIImageView!
    
    // MARK: - Methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
