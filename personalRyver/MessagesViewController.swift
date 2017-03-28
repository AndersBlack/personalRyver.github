//
//  MessagesViewController.swift
//  personalRyver
//
//  Created by Markus Sørensen on 28/03/17.
//  Copyright © 2017 Anders Black. All rights reserved.
//

import UIKit
import Firebase

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    var room : FIRDatabaseReference?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputField: UITextField!
    var messageKeys = [String]()
    var messages = [Message]()
    var observer : UInt = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        observe()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        room?.removeObserver(withHandle: observer)
    }
    
    //tableview stuff
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return messages.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath)
        let message = messages[indexPath.row]
        cell.textLabel?.text = message.text
        cell.detailTextLabel?.text = message.author
        return cell
    }
    
    private func observe()
    {
        observer = (room?.observe(.value, with: { (snapshot) in
            // update tableView
            var newKeyArray = [String]()
            var newItemArray = [Message]()
            for value in snapshot.children
            {
                let snapValue = value as! FIRDataSnapshot
                let message = Message(snapshot: snapValue)
                newKeyArray.append(snapValue.key)
                newItemArray.append(message)
            }
            self.messageKeys = newKeyArray
            self.messages = newItemArray
            self.tableView.reloadData()
        }))!
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton)
    {
        if let text = inputField.text
        {
            sendMessage(text: text)
            inputField.text = ""
        }
    }
    
    func sendMessage(text: String)
    {
        let message = Message(text: text)
        let childRef = self.room?.childByAutoId()
        childRef?.setValue(message.toDictionary())
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    
}
