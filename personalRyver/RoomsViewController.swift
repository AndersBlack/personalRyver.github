import UIKit
import Firebase

class RoomsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    let db = FIRDatabase.database().reference(withPath: "rooms")
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputField: UITextField!
    var roomKeys = [String]()
    var rooms = [Room]()
    var observer : UInt = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPressed(_ sender: UIButton)
    {
        if let text = inputField.text
        {
            createRoom(name: text)
            inputField.text = ""
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        observe()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        //FIRDatabase.removeObserver(observer)
        db.removeObserver(withHandle: observer)
    }
    
    
    //tableview stuff
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return rooms.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roomCell", for: indexPath) 
        let room = rooms[indexPath.row]
        cell.textLabel?.text = room.name
        cell.detailTextLabel?.text = room.author
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let roomID = roomKeys[indexPath.row]
        performSegue(withIdentifier: "ShowMessages", sender: roomID)
    }
    
    func createRoom(name: String)
    {
        let room = Room(name: name)
        let childRef = self.db.childByAutoId()
        childRef.setValue(room.toDictionary())
    }
    
    private func observe()
    {
        observer = db.observe(.value, with: { (snapshot) in
            // update tableView
            var newKeyArray = [String]()
            var newItemArray = [Room]()
            for value in snapshot.children
            {
                let snapValue = value as! FIRDataSnapshot
                let room = Room(snapshot: snapValue)
                print("room: \(room.name)")
                newKeyArray.append(snapValue.key)
                newItemArray.append(room)
            }
            self.roomKeys = newKeyArray
            self.rooms = newItemArray
            self.tableView.reloadData()
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destinationVC = segue.destination as? MessagesViewController
        {
            if let roomID = sender as? String
            {
                destinationVC.room = db.child(roomID)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
