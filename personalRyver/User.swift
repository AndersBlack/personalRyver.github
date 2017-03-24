//
//  User.swift
//  personalRyver
//
//  Created by Markus Sørensen on 24/03/17.
//  Copyright © 2017 Anders Black. All rights reserved.
//

import Foundation
import Firebase

class User
{
    var email : String
    var username : String
    
    init(email: String, username: String)
    {
        self.email = email
        self.username = username
    }
    
    init(snapshot:FIRDataSnapshot)
    {  // When an object is loaded from Firebase
        let value = snapshot.value as! [String: AnyObject]
        email = value["email"] as! String
        username = value["username"] as! String
    }
    
    func toDictionary() -> Any
    {
        return ["email": email, "username": username]
    }
}
