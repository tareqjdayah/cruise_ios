

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var confirmTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    // Assuming you have a SignUpViewModel like this:
    // (You'll need to implement the actual logic for saving to a SQL database within the view model)
    var viewModel = SignUpViewModel()
    
    @IBAction func signUpABtn(_ sender: Any) {
            guard validateInput() else { return }

            let name = nameTF.text!
            let email = emailTF.text!
            let password = passwordTF.text!

            if viewModel.saveData(name: name, email: email, password: password) {
                // Data saved successfully
                let defaults = UserDefaults.standard
                defaults.set(emailTF.text, forKey: "userEmail")
                defaults.set(nameTF.text, forKey: "userName")
                
                let homeUpVC = self.storyboard?.instantiateViewController(withIdentifier: "homeViewControllerId") as! ViewController
                self.navigationController?.pushViewController(homeUpVC, animated: true)
            
            } else {
                // Failed to save data
                showMessage(title: "Error", message: "Failed to save data. Please try again.")
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.black

    }

    
    func validateInput() -> Bool {
        guard let name = nameTF.text, !name.isEmpty else {
            showMessage(title: "Error",message: "Name is required!")
            return false
        }
        
        guard let email = emailTF.text, !email.isEmpty, isValidEmail(email) else {
            showMessage(title: "Error",message: "Invalid email!")
            return false
        }
        
        guard let password = passwordTF.text, !password.isEmpty else {
            showMessage(title: "Error",message: "Password is required!")
            return false
        }
        
        guard let confirm = confirmTF.text, confirm == password else {
            showMessage(title: "Error", message: "Passwords do not match!")
            return false
        }
        
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        // This is a simple validation. In a real-world application, consider using a more comprehensive regex.
        return email.contains("@") && email.contains(".")
    }
    
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
