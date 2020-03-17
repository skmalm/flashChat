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
        Timer.scheduledTimer(withTimeInterval: Constants.titleAnimationInterval, repeats: true) { timer in
            if indexTracker >= Constants.titleString.count {
                timer.invalidate()
            } else {
                let index = Constants.titleString.index(Constants.titleString.startIndex, offsetBy: indexTracker)
                let outputString = String(Constants.titleString[Constants.titleString.startIndex...index])
                // adding spaces stops chars from starting out huge
                let spaces = String(repeating: " ", count: Constants.titleString.count - outputString.count)
                self.appNameLabel.text = outputString + spaces
                indexTracker += 1
            }
        }
    }

    // MARK: - Properties
    
    @IBOutlet weak var appNameLabel: UILabel!
    
}
