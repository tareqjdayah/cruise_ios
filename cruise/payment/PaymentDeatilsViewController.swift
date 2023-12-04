
import UIKit

class PaymentDeatilsViewController: UIViewController {

    var cruiseModel: CruiseModel?

    @IBOutlet weak var backgroundView: UIView!
    
    fileprivate func initView() {
        backgroundView.layer.cornerRadius = 10
        backgroundView.clipsToBounds = true
        self.navigationItem.title = "Reservation details"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()

    }
    
    @IBAction func Reserve(_ sender: Any) {
        let paymentVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentViewId") as! PaymentViewController
        paymentVC.cruiseModel = self.cruiseModel
        self.navigationController?.pushViewController(paymentVC, animated: true)
    }
    

}
