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
        listener = db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    print("Error fetching documents: \(error!)")
                    return
                }
                self.messages.removeAll()
                var allMessages = [Message]()
                for document in documents {
                    let documentData = document.data(with: .estimate)
                    if let sender = documentData[K.FStore.senderField] as? String,
                        let body = documentData[K.FStore.bodyField] as? String {
                        allMessages.append(Message(sender: sender, body: body))
                    }
                }
                self.messages = allMessages
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    if let bottomRow = self.tableView.indexPathsForVisibleRows?.last {
                        self.tableView.scrollToRow(at: bottomRow, at: .bottom, animated: true)
                    }
                }
            }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        listener?.remove()
    }
    
    // MARK: - Properties
    
    var handle: AuthStateDidChangeListenerHandle?
    var listener: ListenerRegistration?
    var user: User?
    let db = Firestore.firestore()
    
    var messages = [Message]()
    
    @IBOutlet weak var tableView: UITableView! { didSet {
        tableView.register(UINib(nibName: K.cellNibName, bundle: .main), forCellReuseIdentifier: K.cellIdentifier)
        tableView.dataSource = self
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
            data: [K.FStore.senderField: messageSender, K.FStore.bodyField: messageBody, K.FStore.dateField: Date().timeIntervalSince1970]) { error in
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
        // if message is from logged in user
        if message.sender == user?.email {
            cell.messageLabel.text = message.body
            cell.meAvatar.isHidden = false
            cell.youAvatar.isHidden = true
            cell.messageView.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.purple)
        } else { // if message is not from logged in user
            cell.messageLabel.text = "\(message.sender): \(message.body)"
            cell.meAvatar.isHidden = true
            cell.youAvatar.isHidden = false
            cell.messageView.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.messageLabel.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        return cell
    }
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
