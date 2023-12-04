//
//  SidebarViewController.swift
//  cruise
//
//  Created by Mohammed Mansour on 29/10/2023.
//

import Foundation
import UIKit

class SidebarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let options = ["Login", "Register"]
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle selection
        if indexPath.row == 0 {
            // Handle Login
        } else if indexPath.row == 1 {
            // Handle Register
        }
    }
}
