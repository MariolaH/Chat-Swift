//
//  ChatViewController.swift
//  Chat
//
//  Created by Mariola Hullings on 1/11/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestoreInternal

class ChatViewController: UIViewController {
    //Create reference to the database
    let db = Firestore.firestore()
    //When the tableView loads up, it makes a request for data
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    //Constains an array of message objects
    //messages has a data type of Message which is the data type that is used to structure the messages(Message struct) so they can have a body and sender
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.dataSource is looking to chatVC and trigger the delegate methods in order to get the data that it needs.
        tableView.dataSource = self
        title = "⚡️ Chat"
        navigationItem.hidesBackButton = true
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        loadMessages()
    }
    
    //this method pulls up all the current data inside the database.
    //Then going to use it to populate the tableView
    func loadMessages() {
        messages = []
        //db.collection().getDocuments, this operation is performed in the background
        //This is to ensure that the data fetching process does not block the main thread, which is responsible for maintaining a smooth user interface
        db.collection(Constants.FStore.collectionName).getDocuments { (querySnapshot, error) in
            if let e = error {
                print("There was an issue retrieving data from Firestore. \(e)")
            } else {
                //.documnet - array called documents because this contains the actual documents that saved in that collection
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        //used a conditional downcast to cast (sender) into a string. Before the conditional downcast it was a optional Any?
                        //When you use if let, you're essentially saying, "If the optional contains a value, unwrap it and assign it to a new constant (or variable), and only then execute the code inside the braces."
                        //The data dictionary appears to have optional values, which means they might or might not contain a value. Using if let ensures that sender and messageBody are only assigned values if the respective dictionary lookups succeed and the values can be cast to String.
                        //By using a comma , you're chaining multiple optional bindings together. This means that the code block inside the braces will only execute if both conditions are true: data[Constants.FStore.senderField] can be downcast to a String and assigned to sender, and data[Constants.FStore.bodyField] can also be downcast to a String and assigned to messageBody.
                        if let messageSender = data[Constants.FStore.senderField] as? String,
                           //Also conditional downcast to String
                            let messageBody = data[Constants.FStore.bodyField] as? String {
                            //newMessage is ready to add to the array of messages which is currently empty
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            //tapping into the messages array and appending new messages to it
                            self.messages.append(newMessage)
                            //UI updates, like reloading a table view, must be done on the main thread. However, since the Firestore data fetching is done in the background, you are not on the main thread when you reach the point of needing to update the UI.
                            //DispatchQueue.main.async - is saying, "Schedule this block of code to be executed on the main thread as soon as possible."
                            //DispatchQueue.main is a reference to the main dispatch queue, which is associated with the main thread of the application.
                            //.async is a method that asynchronously dispatches the enclosed block of code for execution on the main queue.
                            DispatchQueue.main.async {
                                //this is manipulating the user interface
                                //what this does it taps into the tableView and triggers the data source methods again
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        //messageBody - stores the messaga body
        //if messageTextfield.text is not nil, save it inside messageBody
        //if there is a current user (Auth.auth().currentUser?.email) logged in, then save their email inside messageBody
        //if these 2 pieces of info are not nil, go into this first block of code where can send these pieces of data to Firebase Firestore.
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email {
            //data - what is being sent to Firestore
            db.collection(Constants.FStore.collectionName).addDocument(data: [
                Constants.FStore.senderField: messageSender,
                Constants.FStore.bodyField: messageBody]) { (error) in
                    if let e = error {
                        print("There was an issue saving data to firestore, \(e)")
                    } else {
                        print("Sucessfully saved data")
                    }
                }
        }
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
