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
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
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

//DataSource is the protocol responsible for populating the tableView
//func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) - how many cell tableView needs
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell - which cells to put into the tableView
extension ChatViewController : UITableViewDataSource {
    //how many rows/cells want in tableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //dynamically returning number of rows depending on how many messages are in the message array(up top)
        return messages.count
    }
    
    //IndexPath is the position
    //this method is asking for a UITableViewCell that it should display in each and every row of our table view
    //this method is going to get called for as many rows as you have in the tableView, (the func about this one) and each time it's asking for a cell for a particular row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //IndexPath (for) is simply the current one that the tableView is requesting some data for
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        //give cell some data
        //textLabel - corresponds to the main label in the cell
        //[indexPath.row] - this line represnts the position of the messages ie. 0, messages[0] - going to pull the first message from the message array
        cell.label?.text = messages[indexPath.row].body
        //return the cell and it will be slotted into the tableview
        return cell
    }
    
    
}
