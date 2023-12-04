

import UIKit

class CruiseTableViewCell: UITableViewCell {

    
    @IBOutlet weak var CruiseIV: UIImageView!
    
    @IBOutlet weak var nameTV: UILabel!
    @IBOutlet weak var descriptionTV: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    
    private var viewController : ViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(cruiseModel :CruiseModel){
        nameTV.text = cruiseModel.name
        descriptionTV.text = cruiseModel.description
        priceLable.text = "$\(cruiseModel.price)/Person"
        CruiseIV.image = UIImage(named: "image1")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     
       
    }

}
