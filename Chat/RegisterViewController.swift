//
//  RegisterViewController.swift
//  Chat
//
//  Created by Mariola Hullings on 1/11/24.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBAction func registerPressed(_ sender: Any) {
        //both email and password have to not be nil for the if statement to be carried out
        if let email = emailTextField.text, let password = passwordTextfield.text {
        if password.count < 6 {
            AlertViewController.showAlert(self, title: "Password Too Short", message: "Password must be at least 6 characters long")
        } else {
            //authResult - users account data after they've been sucessfully registered.
            // the in keyword denotes that this is a closure
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                //if there are no errors or if error is = nil this block is getting skipped and going to proceed to the else block
                if let e = error {
                    AlertViewController.showAlert(self, title: "Error", message: e.localizedDescription)
                    print(e.localizedDescription)
                } else {
                    //Navigate to the chatVC
                    //need to include self becuase in closure
                    //sender: self - origin of the seque. It's attached from the RegisterVC to the ChatVC
                    //add self in front of any method that we are calling on the current class.
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }
    }
}
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


}
