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

    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let userEmail = user?.email {
                self.navigationItem.title = "⚡️\(userEmail)⚡️"
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationItem.hidesBackButton = false
    }
    
    // MARK: - Properties
    
    @IBOutlet weak var messageTextField: UITextField! { didSet { messageTextField.delegate = self}}

    // MARK: - Methods
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            print("User successfully logged out.")
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            print("Not popping to root due to sign out error.")
        }
    }

    
}

// MARK: - Extensions

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
