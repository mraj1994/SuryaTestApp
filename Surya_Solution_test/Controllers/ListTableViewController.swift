//
//  DetailsTableViewCell.swift
//  Surya_Solution_test
//
//  Created by Mraj singh on 28/02/19.
//  Copyright © 2019 Mraj singh. All rights reserved.
//

import UIKit


class ListTableViewController: UITableViewController {
    
    var profileDatalist: [Items]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = profileDatalist {
            return list.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableViewCell", for: indexPath) as! DetailsTableViewCell
        if let profileData = profileDatalist?[indexPath.row] {
            cell.emailLabel.text = profileData.emailId
            if let imageURL = profileData.imageUrl , cell.imageView?.image == nil {
                cell.profileImageView.dowloadFromServer(link: imageURL)
                
            }
            if let firstName = profileData.firstName , let lastName = profileData.lastName {
                cell.fullNameLabel.text = firstName + " " + lastName
            }
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66.0
    }
    
    
}
