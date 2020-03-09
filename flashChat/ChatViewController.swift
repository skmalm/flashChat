//
//  ChatViewController.swift
//  flashChat
//
//  Created by Sebastian Malm on 3/9/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        let rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.hidesBackButton = false
        navigationItem.rightBarButtonItem = nil
    }
    
    @objc private func logOut() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
