//
//  TitleViewController.swift
//  flashChat
//
//  Created by Sebastian Malm on 3/8/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

}
