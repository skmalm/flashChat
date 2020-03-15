//
//  ChatViewController.swift
//  flashChat
//
//  Created by Sebastian Malm on 3/9/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField! { didSet { messageTextField.delegate = self}}
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        let rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let userEmail = user?.email {
                print("In chat scene. \(userEmail) is currently logged in.")
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.hidesBackButton = false
        navigationItem.rightBarButtonItem = nil
    }
    
    @objc private func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("User successfully logged out.")
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            print("Not popping to root due to sign out error.")
        }
    }
    
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        } else {
            textField.endEditing(true)
            return true
        }
    }
}
