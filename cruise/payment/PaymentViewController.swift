
import UIKit

class PaymentViewController: UIViewController {
    
    var cruiseModel: CruiseModel?
    var viewModel = PaymentViewModel()

    
    @IBOutlet weak var CardCheckbox: UIButton!
    
    @IBOutlet weak var ApplePayCheckBox: UIButton!
    
    fileprivate func initView() {
        self.navigationItem.title = "Payment"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        // Initialize and set the button configuration
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "unCheckImg")
        config.baseForegroundColor = .clear // Optional: Set to clear if you don't want any tint effect
        config.baseBackgroundColor = .clear // Optional: Set to clear if you don't want any background color
        CardCheckbox.configuration = config
        
        ApplePayCheckBox.configuration = config
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    @IBAction func ApplePayCheckbox(_ sender: Any) {
        updateButtonConfiguration(ApplePayCheckBox)
    }
    
    @IBAction func CardCheckBox(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        updateButtonConfiguration(CardCheckbox)
    }
    
    
    
    private func updateButtonConfiguration(_ button :UIButton ) {
        var currentConfig = button.configuration ?? UIButton.Configuration.plain()
        let imageName = button.isSelected ? "checkboxImg" : "unCheckImg"
        currentConfig.image = UIImage(named: imageName)
        button.configuration = currentConfig
    }
    
    
    @IBAction func paymentBtn(_ sender: Any) {
        if let model = cruiseModel {
            viewModel.saveCruiseModel(model)

            let homeUpVC = self.storyboard?.instantiateViewController(withIdentifier: "homeViewControllerId") as! ViewController
            self.navigationController?.pushViewController(homeUpVC, animated: true)
        }
    }

}
