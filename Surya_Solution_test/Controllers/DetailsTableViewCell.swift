//
//  DetailsTableViewCell.swift
//  Surya_Solution_test
//
//  Created by Mraj singh on 28/02/19.
//  Copyright © 2019 Mraj singh. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profileImageView.layer.cornerRadius =  profileImageView.frame.height/2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}

