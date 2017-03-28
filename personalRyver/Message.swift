//
//  Message.swift
//  personalRyver
//
//  Created by Markus Sørensen on 28/03/17.
//  Copyright © 2017 Anders Black. All rights reserved.
//

import Foundation
import Firebase

class Message
{
    var text : String
    var author : String
    
    init(text: String)
    {
        self.text = text
        author = (Utility.user?.username)!
    }
    
    init(snapshot:FIRDataSnapshot)
    {  // When an object is loaded from Firebase
        let value = snapshot.value as! [String: AnyObject]
        text = value["text"] as! String
        author = value["author"] as! String
    }
    
    func toDictionary() -> Any
    {
        return ["text": text, "author": author]
    }
}
