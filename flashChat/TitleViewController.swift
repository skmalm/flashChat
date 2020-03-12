//
//  TitleViewController.swift
//  flashChat
//
//  Created by Sebastian Malm on 3/8/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit
import CLTypingLabel

class TitleViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        appNameLabel.text = "⚡️"
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // text is animated when set via CLTypingLabel pod
        appNameLabel.text = "⚡️FlashChat"
    }

    // MARK: - Properties
    
    @IBOutlet weak var appNameLabel: CLTypingLabel!
    
}
