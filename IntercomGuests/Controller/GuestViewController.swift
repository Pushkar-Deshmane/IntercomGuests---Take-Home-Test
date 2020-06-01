//
//  GuestViewController.swift
//  IntercomGuests
//
//  Created by Pushkar Deshmane on 31/05/2020.
//  Copyright © 2020 Pushkar Deshmane. All rights reserved.
//

import UIKit

class GuestViewController: UIViewController {
    
    var destinationList : [CustomerData] = []
    var filteredList : [CustomerData] = []
    
    var resultList : [ResultData] = []
    var i = 0
    
    //IBOutlet declaration
    @IBOutlet weak var guestTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guestTableView.dataSource = self
        
        //Register NIB cell design
        guestTableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        for _ in destinationList{
            filterCustData(destinationList: destinationList[i])
            i+=1
        }
    }
    
    //MARK: - Function to calculate distance in kilometer
    func filterCustData(destinationList : CustomerData){
        
        //formula to calculate the great-circle distance between two points
        
        let r = 6371e3
        
        //The GPS coordinates for customer destination
        let destLat = Double(destinationList.latitude)
        let destLan = Double(destinationList.longitude)
        
        //The GPS coordinates for our Dublin office are 53.339428, -6.257664.
        let originLat = 53.339428
        let originLan = -6.257664
        
        let a1 = destLat! * (3.14/180)
        let a2 = originLat * (3.14/180)
        
        let b1 = (originLat - destLat!) * (.pi/180)
        let b2 = (originLan - destLan!) * (.pi/180)
        
        
        let a = sin(b1/2) * sin(b1/2) + cos(a1) * cos(a2) * sin(b2/2) * sin(b2/2)
        
        //atan2 for conversion from degree to radian
        let c = 2 * atan2(sqrt(a),sqrt(1-a))
        
        let ans = r * c //answer in meter
        
        //meter to kilometer
        let km = ans/1000
        
        if km < 100{
            let res = ResultData(latitude: destinationList.latitude, user_id: destinationList.user_id, name: destinationList.name, longitude: destinationList.longitude, kilometer: (km * 100).rounded()/100)
            
            resultList.append(res)
            //guestTableView.reloadData()
        }
        
    }
}

//MARK: - TableView DataSource Methods
extension GuestViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! CustomerCell
        let result = resultList.sorted(by:{ $0.user_id < $1.user_id})
        cell.nameLabel.text = result[indexPath.row].name
        cell.userIdLabel.text = "User id: \(result[indexPath.row].user_id)"
        cell.distanceFromOrigin.text = "Distance from Intercom Office: \(result[indexPath.row].kilometer) km"
        cell.distanceFromOrigin.isHidden = false
        return cell
    }
}

struct ResultData {
    let latitude: String
    let user_id: Int
    let name: String
    let longitude: String
    let kilometer : Double
    
    init(latitude:String, user_id:Int, name:String, longitude:String, kilometer: Double) {
        self.latitude = latitude
        self.user_id = user_id
        self.name = name
        self.longitude = longitude
        self.kilometer = kilometer
    }
}
