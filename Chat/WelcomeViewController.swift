//
//  WelcomeViewController.swift
//  Chat
//
//  Created by Mariola Hullings on 1/11/24.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    
        //Just before the view shows up on screen
    //navBar is hidden
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    //when transitioning to next screen navBar will be visible
    override func viewWillDisappear(_ animated: Bool) {
        //super - this mean the parent, UIViewController, which our class is inherting from, gets an opportunity to run its own code inside its own viewWillDisappear, and then afterwards, we can run our code which has our custom functionality
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = ""
        //creating a delay for each letter
        var charIndex = 0.0
        let titleText = Constants.appName
        for letter in titleText {
//            print("-")
//            print(0.1 * charIndex)
//            print(letter)
            //this timer adds each letter after an incremental amount of time
            //withTimeInterval is * by charIndex will delay each letter by 0.1 of a second, and it will appear incrementally after each other everytime the loop runs
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                //this code is inside a closure, need to add self
                self.titleLabel.text?.append(letter)
            }
            //everytime the loop runs charIndex increments the delay ie., 1.0, 2.0 etc
            charIndex += 1
        }
    }
}
