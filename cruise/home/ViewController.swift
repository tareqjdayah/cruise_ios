
import UIKit

class ViewController: UIViewController,UITextViewDelegate,UITableViewDataSource, UITableViewDelegate {
    
    
    private var isMenuOpen = false
    private let sideMenuWidth: CGFloat = 200
    private var cruises = [CruiseModel]()
    private let viewModel = HomeViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cruises = viewModel.fetchCruiseList()
        
        cruiseTable.dataSource = self
        cruiseTable.delegate = self
        configuration()
        setupUI()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cruises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cruiseCell", for: indexPath) as! CruiseTableViewCell
        
        cell.setCell(cruiseModel: cruises[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reservationDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "ReservationDetailsId") as! ReservationDetailsViewController
        reservationDetailsVC.cruiseModel = cruises[indexPath.row]
        self.navigationController?.pushViewController(reservationDetailsVC, animated: true)
    }
    
    
    @IBOutlet weak var cruiseTable: UITableView!
    
    private let sideMenu: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.contentEdgeInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0) // Add 10 points top margin
        button.setTitle("Sign In", for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let cartButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Cart", for: .normal)
            button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
            return button
        }()
    
    @objc private func loginButtonTapped() {
        toggleMenu()
        let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "SignInId") as! SignInViewController
        self.navigationController?.pushViewController(signInVC, animated: true)
        
    }
    
    @objc private func registerButtonTapped() {
        toggleMenu()
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpId") as! SignUpViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }  
    
    @objc private func cartButtonTapped() {
        toggleMenu()
        let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "CartViewControllerId") as! CartViewController
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    
    private  func configuration(){
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor.white
        
        let braggerIcon = UIImage(named: "braggerIcon") // Replace with your image name
        let braggerButtonItem = UIBarButtonItem(image: braggerIcon, style: .plain, target: self, action: #selector(braggerTapped))
        navigationItem.leftBarButtonItem = braggerButtonItem
        
        navigationItem.leftBarButtonItem = braggerButtonItem
        
        
        // 2. Set the logo in the center of the navigation bar
        let logo = UIImage(named: "logo") // Replace with your logo image name
        let imageView = UIImageView(image: logo)
        navigationItem.titleView = imageView
        
        // 3. Set the filter icon on the right
        let filterIcon = UIImage(named: "filterIcon") // Replace with your image name
        let filterButtonItem = UIBarButtonItem(image: filterIcon, style: .plain, target: self, action: #selector(filterTapped))
        
        // 4. Add a profile icon next to the filter icon
        let profileIcon = UIImage(named: "profileIcon") // Replace with your image name
        let profileButtonItem = UIBarButtonItem(image: profileIcon, style: .plain, target: self, action: #selector(profileTapped))
        profileButtonItem.tintColor = UIColor.gray // Set the tint color to gray
        
        navigationItem.rightBarButtonItems = [filterButtonItem, profileButtonItem]
        
    }
    
    @objc func braggerTapped() {
        toggleMenu()
    }
    
    @objc func profileTapped() {
        let reservationDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "profileViewControllerId") as! ProfileViewController
        self.navigationController?.pushViewController(reservationDetailsVC, animated: true)
    }
    
    private func toggleMenu() {
        isMenuOpen = !isMenuOpen
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.isMenuOpen {
                self.sideMenu.frame.origin.x = 0
                self.navigationItem.titleView?.isHidden = true
            } else {
                self.navigationItem.titleView?.isHidden = false
                self.sideMenu.frame.origin.x = -self.sideMenuWidth
            }
        })
    }
    
    
    @objc func filterTapped() {
        let actionSheet = UIAlertController(title: nil, message: "Choose a filter", preferredStyle: .actionSheet)
        
        let option1Action = UIAlertAction(title: "Bahamas Cruise", style: .default) { _ in
            self.cruises = self.viewModel.fetchCruises(forType: "Bahamas")
            self.cruiseTable.reloadData()
        }
        
        let option2Action = UIAlertAction(title: "Caribbean Cruise", style: .default) { _ in
            self.cruises = self.viewModel.fetchCruises(forType: "Caribbean")
            self.cruiseTable.reloadData()
        }
        
        let option3Action = UIAlertAction(title: "Cuba Cruise", style: .default) { _ in
            self.cruises = self.viewModel.fetchCruises(forType: "Cuba")
            self.cruiseTable.reloadData()
        }
        
        let option4Action = UIAlertAction(title: "Sampler Cruise", style: .default) { _ in
            self.cruises = self.viewModel.fetchCruises(forType: "Sampler")
            self.cruiseTable.reloadData()
        }
        
        let option5Action = UIAlertAction(title: "Star Cruise", style: .default) { _ in
            self.cruises = self.viewModel.fetchCruises(forType: "Star")
            self.cruiseTable.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.cruises = self.viewModel.fetchCruiseList()
            self.cruiseTable.reloadData()
        }
        actionSheet.addAction(option1Action)
        actionSheet.addAction(option2Action)
        actionSheet.addAction(option3Action)
        actionSheet.addAction(option4Action)
        actionSheet.addAction(option5Action)
        actionSheet.addAction(cancelAction)
        
        // For iPad support
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    private func setupUI() {
        // Setup main view
        view.backgroundColor = .white
        
        // Setup side menu
        sideMenu.frame = CGRect(x: -sideMenuWidth, y: 0, width: sideMenuWidth, height: view.frame.size.height)
        view.addSubview(sideMenu)
        
        let stackView = UIStackView(arrangedSubviews: [loginButton, registerButton,cartButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        sideMenu.addSubview(stackView)
        
        // Calculate top padding, taking into account possible safe area insets (for devices with notches)
        let topPadding = view.safeAreaInsets.top + (navigationController?.navigationBar.frame.height ?? 0)
        
        // Constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: sideMenu.topAnchor, constant: topPadding + 10), // 10 is for some spacing, adjust as needed
            stackView.leadingAnchor.constraint(equalTo: sideMenu.leadingAnchor, constant: 20), // Adjust the leading constant for the left margin
            stackView.widthAnchor.constraint(equalToConstant: 100) // Adjust the width as needed
        ])
    }
}

