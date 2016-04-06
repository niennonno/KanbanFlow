//
//  UserDetailsTableViewCell.swift
//  KanbanFlow
//
//  Created by Aditya Vikram Godawat on 05/04/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell, UIScrollViewDelegate {

    @IBOutlet var aBoardName: UILabel!
    
    @IBOutlet var scrollView: UIScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollView.delegate = self
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        scrollView.setContentOffset(CGPointMake(scrollView.contentOffset.x, 0), animated: false)
        
    }
    
}
