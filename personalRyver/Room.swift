//
//  Room.swift
//  personalRyver
//
//  Created by Markus Sørensen on 28/03/17.
//  Copyright © 2017 Anders Black. All rights reserved.
//

import Foundation
import Firebase

class Room
{
    var name : String
    var author : String
    
    init(name: String)
    {
        self.name = name
        author = (Utility.user?.username)!
    }
    
    init(snapshot:FIRDataSnapshot)
    {  // When an object is loaded from Firebase
        let value = snapshot.value as! [String: AnyObject]
        name = value["name"] as! String
        author = value["author"] as! String
    }
    
    func toDictionary() -> Any
    {
        return ["name": name, "author": author]
    }
}
