//
//  Constants.swift
//  flashChat
//
//  Created by Sebastian Malm on 3/17/20.
//  Copyright © 2020 SebastianMalm. All rights reserved.
//

import Foundation

struct K {
    static let titleString = "⚡️FlashChat"
    static let titleAnimationInterval: TimeInterval = 0.1
    static let registerToChatSegueID = "RegisterToChat"
    static let loginToChatSegueID = "LoginToChat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
}

/*
 
 These are the constants supplied by Angela.
 I won't actually add them until I see where/how/why she uses them.
 
 struct K {
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
 
 */
