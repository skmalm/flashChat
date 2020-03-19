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
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            self.user = user
            if let userEmail = user?.email {
                self.title = "⚡️\(userEmail)⚡️"
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    // MARK: - Properties
    
    var handle: AuthStateDidChangeListenerHandle?
    var user: User?
    let db = Firestore.firestore()
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey!"),
        Message(sender: "a@b.com", body: "Hello!"),
        Message(sender: "1@2.com", body: "What's Up?"),
        Message(sender: "a@b.com", body: "How should I know? The sky? I don't bloody know. I've been in this underground bunker for several years now. 🤷🏼‍♀️")
    ]
    
    @IBOutlet weak var tableView: UITableView! { didSet {
        tableView.register(UINib(nibName: K.cellNibName, bundle: .main), forCellReuseIdentifier: K.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        }}
    @IBOutlet weak var messageTextField: UITextField! { didSet { messageTextField.delegate = self}}

    // MARK: - Methods
    
    @IBAction func send(_ sender: UIButton) {
        sendMessage()
    }
    
    func sendMessage() {
        guard let messageBody = messageTextField.text, !messageBody.isEmpty else { return }
        if let messageSender = user?.email {
            db.collection(K.FStore.collectionName).addDocument(
            data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody]) { error in
                if error == nil {
                    print("Successfully saved data to firestore")
                } else {
                    print("Error saving data to firestore: \(error!)")
                }
            }
        }
        messageTextField.endEditing(true)
        messageTextField.text = ""
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            print("User successfully logged out.")
            if handle != nil {
                Auth.auth().removeStateDidChangeListener(handle!)
            }
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            print("Not popping to root due to sign out error.")
        }
    }

    
}

// MARK: - Extensions

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        cell.messageLabel.text = "\(message.sender): \(message.body)"
        return cell
    }
}

extension ChatViewController: UITableViewDelegate {
    // Not using any delegate properties/methods yet
    // Delete this and remove delegate assignment if not needed
}

extension ChatViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        } else {
            sendMessage()
            return true
        }
    }
}
