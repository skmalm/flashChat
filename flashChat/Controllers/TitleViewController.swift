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
        var indexTracker = 0
        Timer.scheduledTimer(withTimeInterval: K.titleAnimationInterval, repeats: true) { timer in
            if indexTracker >= K.titleString.count {
                timer.invalidate()
            } else {
                let index = K.titleString.index(K.titleString.startIndex, offsetBy: indexTracker)
                let outputString = String(K.titleString[K.titleString.startIndex...index])
                // adding spaces stops chars from starting out huge
                let spaces = String(repeating: " ", count: K.titleString.count - outputString.count)
                self.appNameLabel.text = outputString + spaces
                indexTracker += 1
            }
        }
    }

    // MARK: - Properties
    
    @IBOutlet weak var appNameLabel: UILabel!
    
}
