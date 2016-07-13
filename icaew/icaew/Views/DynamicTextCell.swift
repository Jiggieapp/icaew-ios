//
//  DynamicTextCell.swift
//  icaew
//
//  Created by Setiady Wiguna on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

class DynamicTextCell: UITableViewCell {
    
    @IBOutlet var dynamicTextLabel: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "DynamicTextCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
