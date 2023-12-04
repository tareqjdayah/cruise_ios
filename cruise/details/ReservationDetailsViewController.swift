
import UIKit

class ReservationDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var shipLabel: UILabel!
    @IBOutlet weak var portsLabel: UILabel!
    
    @IBOutlet weak var visitingLabel: UILabel!
    @IBOutlet weak var nightsLabel: UILabel!
    
    var cruiseModel : CruiseModel?
    
    @IBOutlet weak var bordView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    @IBAction func ReserveBtn(_ sender: Any) {
        let reservationDetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "PaymentDeatilsViewId") as! PaymentDeatilsViewController
        reservationDetailsVC.cruiseModel = self.cruiseModel
        self.navigationController?.pushViewController(reservationDetailsVC, animated: true)
        
        
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reservationDetailsViewCell", for: indexPath) as! ReservationDetailsIdCollectionViewCell
        cell.setCell(image:"image2")
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height:  collectionView.frame.height)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        fillData()
        initView()
    }
    
    func fillData(){
        titleLabel.text = cruiseModel?.name
        priceLabel.text = "$\(cruiseModel!.price) / Person"
        descriptionLabel.text = cruiseModel?.description
        shipLabel.text = cruiseModel?.ship
        portsLabel.text = cruiseModel?.ports
        visitingLabel.text = cruiseModel?.visitingPlaces
        nightsLabel.text = cruiseModel?.nights
    }
    
    func initView(){
        self.navigationItem.title = "Details"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        
        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        
        
        bordView.layer.cornerRadius = 10
        bordView.clipsToBounds = true
    }
    
    
}
