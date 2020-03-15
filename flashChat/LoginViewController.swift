//
//  LoginViewController.swift
//  flashChat
//
//  Created by Sebastian Malm on 3/9/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField! { didSet {emailTextField.delegate = self}}
    @IBOutlet weak var passwordTextField: UITextField! { didSet {passwordTextField.delegate = self}}
    @IBAction func login(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
              guard let strongSelf = self else { return }
                if error != nil {
                    print(error!)
                    let alert = UIAlertController(
                        title: "Authetication Error",
                        message: error!.localizedDescription,
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK",style: .default))
                    strongSelf.present(alert, animated: true)
                } else {
                    if let userEmail = authResult?.user.email {
                        print("\(userEmail) successfully logged in")
                        strongSelf.performSegue(withIdentifier: "LoginToChat", sender: strongSelf)
                    }
                }
            }
        }
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return false
        } else {
            textField.endEditing(true)
            return true
        }
    }
}
