
import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    
    var viewModel = SignInViewModel()
    
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = UIColor.black
        
        
    }
    
    
    @IBAction func signInBtn(_ sender: Any) {
        
        guard let email = emailTF.text, !email.isEmpty else {
            showMessage(title: "Error", message: "Email is required!")
            return
        }
        
        guard let password = passwordTF.text, !password.isEmpty else {
            showMessage(title: "Error", message: "Password is required!")
            return
        }
        
        let userInfo = viewModel.getUserInfo(email: email, password: password)
        if userInfo.isRegistered {
            // Save email and name to UserDefaults
            let defaults = UserDefaults.standard
            defaults.set(email, forKey: "userEmail")
            if let userName = userInfo.name {
                defaults.set(userName, forKey: "userName")
            }
            let homeUpVC = self.storyboard?.instantiateViewController(withIdentifier: "homeViewControllerId") as! ViewController
            self.navigationController?.pushViewController(homeUpVC, animated: true)
        } else {
            // Show an error message if credentials are incorrect
            showMessage(title: "Error", message: "Invalid email or password.")
        }
        
    }
    
    
    @IBAction func registerNowBtn(_ sender: Any) {
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpId") as! SignUpViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
        print("SignUpId")
    }
    
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    
}
