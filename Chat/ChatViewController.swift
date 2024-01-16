//
//  ChatViewController.swift
//  Chat
//
//  Created by Mariola Hullings on 1/11/24.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {

    //When the tableView loads up, it makes a request for data
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    //Constains an array of message objects
    //messages has a data type of Message which is the data type that is used to structure the messages(Message struct) so they can have a body and sender
    let messages: [Message] = [
        Message(sender: "1@2.com", body: "Hi"),
        Message(sender: "a@b.com", body: "Hello"),
        Message(sender: "1@2.com", body: "What's up?")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.dataSource is looking to chatVC and trigger the delegate methods in order to get the data that it needs.
        tableView.dataSource = self
        title = "⚡️ Chat"
        navigationItem.hidesBackButton = true
    }

    @IBAction func sendPressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutButton(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            //this line of code sends user to the root VC
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}


extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
