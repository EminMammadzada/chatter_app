import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var passwordOutlet: UITextField!
    @IBOutlet weak var usernameOutlet: UITextField!
    @IBOutlet weak var emailOutlet: UITextField!
    @IBOutlet weak var signupOutlet: UIButton!
    
    
    func addShadow(to element: UIControl){
        element.layer.cornerRadius = 5
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOffset = CGSize(width: 4, height: 4)
        element.layer.shadowRadius = 4
        element.layer.shadowOpacity = 0.1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow(to: signupOutlet)
        addShadow(to: passwordOutlet)
        addShadow(to: usernameOutlet)
        addShadow(to: emailOutlet)
        
    }
    @IBAction func signupPressed(_ sender: UIButton) {
        if let email = emailOutlet.text, let password = passwordOutlet.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                
                if let e = error{
                    // create the alert
                    let alert = UIAlertController(title: "Error creating an account", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                    
                }else{
                    self.performSegue(withIdentifier: K.registerToChatsSegue, sender: self)
                }
            }
        }
    }
}


