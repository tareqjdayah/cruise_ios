//
//  CartViewController.swift
//  cruise
//
//  
//

import UIKit

class CartViewController: UIViewController,UITextViewDelegate,UITableViewDataSource, UITableViewDelegate  {

    
    private var cruises = [CruiseModel]()
    private let viewModel = CartViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Cart"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        cruises = viewModel.fetchCruiseList()
        
        cruiseTable.dataSource = self
        cruiseTable.delegate = self
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
    

    
    
    

  
}
