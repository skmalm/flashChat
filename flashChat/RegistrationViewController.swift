//
//  RegistrationViewController.swift
//  flashChat
//
//  Created by Sebastian Malm on 3/9/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField! { didSet {emailTextField.delegate = self}}
    @IBOutlet weak var passwordTextField: UITextField! { didSet {passwordTextField.delegate = self}}
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func register(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    print(error!)
                    let alert = UIAlertController(
                        title: "Authentication Error",
                        message: error!.localizedDescription,
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK",style: .default))
                    self.present(alert, animated: true)
                } else {
                    if let user = authResult?.user {
                        guard user.email != nil else { return }
                        print("\(user.email!) was successfully registered")
                        self.performSegue(withIdentifier: Constants.registerToChatSegueID, sender: self)
                    }
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        } else {
            textField.endEditing(true)
            return true
        }
    }
}
