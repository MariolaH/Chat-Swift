//
//  Constants.swift
//  Chat
//
//  Created by Mariola Hullings on 1/11/24.
//

struct Constants {
    //Static - adding static keyword infront of the let keyword means that that line do code has now become a type property
    //its a property that's associated with the Constant data type
    static let appName = "⚡️ Chat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
