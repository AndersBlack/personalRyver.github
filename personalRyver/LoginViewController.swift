//
//  ViewController.swift
//  personalRyver
//
//  Created by Anders Black on 24/03/2017.
//  Copyright © 2017 Anders Black. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController
{
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        login()
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
		
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue)
    {
        
    }
    
    func login()
    {
        FIRAuth.auth()?.signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
        
            if error == nil
            {
                self.loadUser(userID: (user?.uid)!)
                self.performSegue(withIdentifier: "ShowRooms", sender: nil)
            }
            else
            {
                 Utility.presentErrorAlert(view: self, error: error)
            }
        }
    }
    
    func loadUser(userID:String)
    {
        let users = FIRDatabase.database().reference(withPath: "users")
        users.child(userID).observeSingleEvent(of: .value, with:
            { (snapshot) in
                let user = User(snapshot: snapshot)
                Utility.userID = userID
                Utility.user = user
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

