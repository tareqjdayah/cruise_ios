//
//  ProfileViewController.swift
//  cruise
//
//  
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameLable: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    var viewModel = ProfileViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userEmail = UserDefaults.standard.string(forKey: "userEmail") {
                  if let userDetails = viewModel.fetchUserDetails(email: userEmail) {
                      nameLable.text = userDetails.name
                      emailLabel.text = userDetails.email
                  } else {
                      // Handle the case where user details are not found
                  }
              } else {
                  // Handle the case where the email is not stored in UserDefaults
              }
       
    }
    


}
