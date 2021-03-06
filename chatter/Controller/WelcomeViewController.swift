import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var loginOutlet: UIButton!
    
    func addShadow(to element: UIControl){
        element.layer.cornerRadius = 5
        element.layer.shadowColor = UIColor.black.cgColor
        element.layer.shadowOffset = CGSize(width: 5, height: 5)
        element.layer.shadowRadius = 5
        element.layer.shadowOpacity = 0.2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow(to: loginOutlet)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.welcomeToLoginSegue, sender: self)
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        performSegue(withIdentifier: K.welcomeToRegisterSegue, sender: self)
    }
    
    
}
