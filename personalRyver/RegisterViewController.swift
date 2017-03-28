//
//  RegisterViewController.swift
//  personalRyver
//
//  Created by Markus Sørensen on 24/03/17.
//  Copyright © 2017 Anders Black. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController
{
    let users = FIRDatabase.database().reference(withPath: "users")
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
		//Looks for single or multiple taps.
		let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
		
		//Uncomment the line below if you want the tap not not interfere and cancel other interactions.
		//tap.cancelsTouchesInView = false
		
		view.addGestureRecognizer(tap)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func acceptPressed(_ sender: UIButton)
    {
        if (usernameField.text?.characters.count)! > 5
        {
            createUser(sender: sender)
			dismissKeyboard()
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton)
    {
        performSegue(withIdentifier: "unwindToLogin", sender: nil)
		dismissKeyboard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createUser(sender: Any)
    {
        if let email = emailField.text, let username = usernameField.text
        {
            FIRAuth.auth()?.createUser(withEmail: email, password: passwordField.text!)
            {
				(user, error) in
				
				if error == nil
                {
                    let userObj = User(email: email, username: username)
                    let childRef = self.users.child((user?.uid)!)
                    childRef.setValue(userObj.toDictionary())
                    
                    self.performSegue(withIdentifier: "unwindToLogin", sender: sender)
                }
					
                else
                {
                    Utility.presentErrorAlert(view: self, error: error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destinationVC = segue.destination as? LoginViewController
        {
            if let button = sender as? UIButton
            {
                if(button.tag == 1)
                {
                    destinationVC.emailField.text = emailField.text
                    destinationVC.passwordField.text = passwordField.text
                }
            }
        }
    }
	
	//Calls this function when the tap is recognized.
	func dismissKeyboard() {
		//Causes the view (or one of its embedded text fields) to resign the first responder status.
		view.endEditing(true)
	}
	

}
