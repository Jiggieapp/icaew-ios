//
//  ProgrammesTableViewCell.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/1/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

class ProgrammesTableViewCell: UITableViewCell {

    @IBOutlet var wrapperView: UIView!
    @IBOutlet var roundedView: UIView!
    @IBOutlet var initialLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "ProgrammesTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.wrapperView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.wrapperView.layer.borderWidth = 1
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundedView.layer.cornerRadius = CGRectGetHeight(self.roundedView.bounds) / 2
        self.roundedView.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
