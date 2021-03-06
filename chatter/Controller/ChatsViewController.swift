import UIKit
import Firebase
import FirebaseFirestore

class ChatsViewController: UIViewController{
    
    @IBOutlet weak var textfieldOutlet: UITextField!
    
    private var messages:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
