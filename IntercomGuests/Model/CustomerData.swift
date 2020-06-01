//
//  CustomerData.swift
//  IntercomGuests
//
//  Created by Pushkar Deshmane on 30/05/2020.
//  Copyright © 2020 Pushkar Deshmane. All rights reserved.
//

import Foundation

struct CustomerData {
    
    let latitude: String
    let user_id: Int
    let name: String
    let longitude: String
    
    init(latitude:String, user_id:Int, name:String, longitude:String) {
        self.latitude = latitude
        self.user_id = user_id
        self.name = name
        self.longitude = longitude
    }
}

