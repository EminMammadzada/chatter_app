import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var loginOutlet: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    func addShadow(to element: UIControl){
        element.layer.cornerRadius = 5
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOffset = CGSize(width: 4, height: 4)
        element.layer.shadowRadius = 4
        element.layer.shadowOpacity = 0.1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow(to: emailTextField)
        addShadow(to: passwordTextField)
        addShadow(to: loginOutlet)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                
                if let e = error{
                    // create the alert
                    let alert = UIAlertController(title: "Error logging in", message: e.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    // show the alert
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.performSegue(withIdentifier: K.loginToChatsSegue, sender: self)
                }
            }
        }
    }
    
}
