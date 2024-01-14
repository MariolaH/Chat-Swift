//
//  LoginViewController.swift
//  Chat
//
//  Created by Mariola Hullings on 1/11/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            //the user's account data will live in the authResult objest that we get back, it is used inside the closure block  or can check to see if there were any errors
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error {
                    print(e.localizedDescription)
                    //if error is nil proced with next code block, the login
                    AlertViewController.showAlert(self!, title: "Login Failed", message: e.localizedDescription)
                } else {
                    self?.performSegue(withIdentifier: Constants.loginSegue, sender: self)
                }
                
            }
        }
    }
    
}

