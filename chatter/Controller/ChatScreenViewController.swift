import UIKit
import Firebase
import FirebaseFirestore
import MessageKit

class ChatScreenViewController: UIViewController{

    @IBOutlet weak var textOutlet: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = []
    var db = Firestore.firestore()
    var recipient = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = recipient
        tableView.dataSource = self
        load_messages()
    }
    
    //MARK: - Firestore related functions (uploading,querying data from Cloud)
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let messageBody = textOutlet.text, let sender = Auth.auth().currentUser?.email{
            K.collectionsCreated.append("\([sender,recipient].sorted()[0])&\([sender,recipient].sorted()[1])")
            db.collection(K.collectionsCreated[K.collectionsCreated.count-1] as! String).addDocument(data:[
                K.FStore.senderField:sender,
                K.FStore.bodyField:messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    DispatchQueue.main.async{
                        self.textOutlet.text = ""
                    }
                    return
                }
            }
        }
    }
    
    func load_messages(){
        
        if let sender = Auth.auth().currentUser?.email{
            db.collection("\([sender,recipient].sorted()[0])&\([sender,recipient].sorted()[1])")
                .order(by: K.FStore.dateField)
                .addSnapshotListener { querySnapshot, error in
                  
                    self.messages = []
                    if let e = error{
                        print("Error fetching data \(e)")
                    }else{
                        if let snapshotDocs = querySnapshot?.documents{
                            for doc in snapshotDocs{
                                let data = doc.data()
                                if let sender = data[K.FStore.senderField] as? String, let body = data[K.FStore.bodyField] as? String{
                                    let message = Message(sender: sender, body: body)
                                    self.messages.append(message)
                                    
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()
                                        let indexpath = IndexPath(row: self.messages.count-1, section: 0)
                                        self.tableView.scrollToRow(at: indexpath, at: .top, animated: true)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
//MARK:- TableView delegate methods

extension ChatScreenViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCell)!
        cell.textLabel?.text = message.body
        
        
        if message.sender == Auth.auth().currentUser?.email{
            cell.backgroundColor = .green
            cell.textLabel?.textColor = UIColor.white
        }
        else{
            cell.backgroundColor = UIColor.white
            cell.textLabel?.textColor = UIColor.black
        }
        
        return cell
    }
}
