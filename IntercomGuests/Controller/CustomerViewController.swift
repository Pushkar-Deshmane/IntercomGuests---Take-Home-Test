//
//  ViewController.swift
//  IntercomGuests
//
//  Created by Pushkar Deshmane on 30/05/2020.
//  Copyright © 2020 Pushkar Deshmane. All rights reserved.
//

import UIKit
import ChameleonFramework
class CustomerViewController: UIViewController {
    
    let list = GuestList()
    
    //IBOutlet declaration
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //table view datasource delegate
        tableView.dataSource = self
        
        //Register XIB design
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //set navigation bar color
        let colors:[UIColor] = [
            UIColor.flatSkyBlue(),
            UIColor.flatWhite()
        ]
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation controller does not exist.")}
        navBar.barTintColor = UIColor(hexString: "#B3E5FC")
        navBar.barTintColor = GradientColor(.leftToRight, frame: view.frame, colors: colors)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue"{
            let destinationVC = segue.destination as! GuestViewController
            destinationVC.destinationList = list.getData()
        }
        
    }
}

//MARK: - TableView DataSource Methods
extension CustomerViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! CustomerCell
        let customerList = list.getData()
        cell.nameLabel.text = customerList[indexPath.row].name
        cell.userIdLabel.text = "User id: \(customerList[indexPath.row].user_id)"
        cell.distanceFromOrigin.isHidden = true
        return cell
    }
}
