import UIKit
import Firebase


class ChatsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textfieldOutlet: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func startChattingPressed(_ sender: UIButton) {
        if let recipient = textfieldOutlet.text{
            Auth.auth().fetchSignInMethods(forEmail: recipient) { signInMethods, error in
                if error != nil{
                    // create the alert
                    let alert = UIAlertController(title: "Error", message: "No such user found", preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.performSegue(withIdentifier:K.chatsToMessagesSegue, sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.chatsToMessagesSegue{
            let destinationVC = segue.destination as! ChatScreenViewController
            let recipient = textfieldOutlet.text
            destinationVC.recipient = recipient!
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        do {
          try Auth.auth().signOut()
          navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            let alert = UIAlertController(title: "Error logging in", message: signOutError.localizedDescription, preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//MARK:- Table view data source delegate

extension ChatsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 //will be changed
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
