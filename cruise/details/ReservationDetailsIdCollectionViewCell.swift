
import UIKit

class ReservationDetailsIdCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var imgCell: UIImageView!
   
    func setCell(image : String){
        imgCell.image = UIImage(named:image)
    }
}
