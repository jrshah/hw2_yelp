//
//  SwitchCell.swift
//  Yelp
//
//  Created by Jay Shah on 9/19/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol SwitchCellDelegate {
    optional func switchCell(switchCell: SwitchCell, didChangeValue value: Bool)
}

class SwitchCell: UITableViewCell {
    
    @IBOutlet weak var categoryNameSwitchLabel: UILabel!
    
    @IBOutlet weak var categorySwitch: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        categorySwitch .addTarget(self, action: "switchValueChanged", forControlEvents :  UIControlEvents.ValueChanged)
        
    }
    
    func switchValueChanged () {
        delegate?.switchCell?(self, didChangeValue: categorySwitch.on)
    }
    
}
