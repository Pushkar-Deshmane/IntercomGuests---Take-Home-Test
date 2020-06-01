//
//  CustomerCell.swift
//  IntercomGuests
//
//  Created by Pushkar Deshmane on 31/05/2020.
//  Copyright © 2020 Pushkar Deshmane. All rights reserved.
//

import UIKit

class CustomerCell: UITableViewCell {
    
    @IBOutlet weak var customerBubble: UIView!
    @IBOutlet weak var userIdLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceFromOrigin: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customerBubble.layer.cornerRadius = customerBubble.frame.size.height/5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
