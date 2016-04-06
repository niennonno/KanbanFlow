//
//  CardView.swift
//  KanbanFlow
//
//  Created by Aditya Vikram Godawat on 06/04/16.
//  Copyright © 2016 Wow Labz. All rights reserved.
//

import UIKit

class CardView: UIView {

    // MARK: Initialization

    required init?(coder aDecoder: NSCoder) {

        super.init(coder: aDecoder)
    
        let padding = 5.0
        self.backgroundColor = UIColor.blueColor()
        
        let columnNameLabel = UILabel(frame: CGRect(x:0 , y: 0, width:self.frame.width - CGFloat(padding * 2.0 ), height: 20))
        columnNameLabel.text = "Coulmn"
        columnNameLabel.center = CGPoint(x: self.frame.width/2, y: 15   )
        columnNameLabel.adjustsFontSizeToFitWidth = true
        columnNameLabel.textColor = UIColor.whiteColor()
        columnNameLabel.font = UIFont.boldSystemFontOfSize(17)
        columnNameLabel.textAlignment = .Center
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(columnNameLabel)                             //Coulmn Name Constraint
        
        
        
        let estimateLabel = UILabel(frame: CGRect(x:0 , y: 0, width:self.frame.width - CGFloat(padding * 2.0 ), height: 20))
        estimateLabel.textAlignment = .Center
        estimateLabel.text = "Estimate"
        estimateLabel.center = CGPoint(x: self.frame.width/2, y: 50)
        estimateLabel.adjustsFontSizeToFitWidth = true
        estimateLabel.textColor = UIColor.whiteColor()
        estimateLabel.font = estimateLabel.font.fontWithSize(14)
        estimateLabel.textAlignment = .Center

        addSubview(estimateLabel)                               //Estimate Label Constraints
        
        let spentLabel = UILabel(frame: CGRect(x:0 , y: 0, width:self.frame.width - CGFloat(padding * 2.0 ), height: 20))
spentLabel.textAlignment = .Center
spentLabel.text = "Spent"
spentLabel.center = CGPoint(x: self.frame.width/2, y: 75)
spentLabel.adjustsFontSizeToFitWidth = true
     spentLabel.textColor = UIColor.whiteColor()
        spentLabel.font = estimateLabel.font.fontWithSize(14)
        spentLabel.textAlignment = .Center
        
        addSubview(spentLabel)                               //Spent Label Constraints

        
        
        
    }
    
}
