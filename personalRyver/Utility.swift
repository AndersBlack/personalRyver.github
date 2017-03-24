//
//  Utility.swift
//  personalRyver
//
//  Created by Markus Sørensen on 24/03/17.
//  Copyright © 2017 Anders Black. All rights reserved.
//

import Foundation
import Firebase

public class Utility
{
    private static let users = FIRDatabase.database().reference(withPath: "users")
    
    static var userID : String? = nil
    static var user : User? = nil
    
    static func presentErrorAlert(view: UIViewController, error: Error?)
    {
        if let errorText = error?.localizedDescription
        {
            let alertController = UIAlertController(title: "Error", message: errorText, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel) { (_) in }
            alertController.addAction(okAction)
            view.present(alertController, animated: true, completion: nil)
        }
        
    }
    
}
