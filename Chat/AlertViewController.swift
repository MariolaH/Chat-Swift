//
//  AlertViewController.swift
//  Chat
//
//  Created by Mariola Hullings on 1/11/24.
//

import UIKit

class AlertViewController {
    static func showAlert(_ inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        inViewController.present(alert, animated: true, completion: nil)
    }
}
