//
//  ViewController.swift
//  personalRyver
//
//  Created by Anders Black on 24/03/2017.
//  Copyright © 2017 Anders Black. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController
{
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    @IBAction func unwindToLogin(segue: UIStoryboardSegue)
    {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

