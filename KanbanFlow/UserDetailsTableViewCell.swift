//
//  UserDetailsTableViewCell.swift
//  KanbanFlow
//
//  Created by Aditya Vikram Godawat on 05/04/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {

    @IBOutlet var aBoardName: UILabel!
    
    @IBOutlet var aColumnView: UIView!
    
    @IBOutlet var aColumnName: UILabel!
    
    @IBOutlet var aColumnPoints: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
