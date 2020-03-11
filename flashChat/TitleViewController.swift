//
//  TitleViewController.swift
//  flashChat
//
//  Created by Sebastian Malm on 3/8/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit

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
        let titleString = "⚡️FlashChat"
        var indexTracker = 0
        Timer.scheduledTimer(withTimeInterval: Constants.titleAnimationInterval, repeats: true) { timer in
            if indexTracker >= titleString.count {
                timer.invalidate()
            } else {
                let index = titleString.index(titleString.startIndex, offsetBy: indexTracker)
                let outputString = String(titleString[titleString.startIndex...index])
                // adding spaces stops chars from starting out huge
                let spaces = String(repeating: " ", count: titleString.count - outputString.count)
                self.appNameLabel.text = outputString + spaces
                indexTracker += 1
            }
        }
    }

    // MARK: - Properties
    
    @IBOutlet weak var appNameLabel: UILabel!
    
}

// MARK: - Extensions

extension TitleViewController {
    struct Constants {
        static let titleAnimationInterval: TimeInterval = 0.08
    }
}
