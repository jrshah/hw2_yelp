//
//  RadioButtonCell.swift
//  Yelp
//
//  Created by Jay Shah on 9/21/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol RadioButtonCellDelegate {
    optional func radioButtonCell(radioButtonCell: RadioButtonCell, didSelectOption value: String)
}
class RadioButtonCell: UITableViewCell {
    
    @IBOutlet weak var radioButtonLabel: UILabel!
    @IBOutlet weak var radioCellButton: UIButton!
    @IBOutlet weak var radioValueLabel: UILabel!
    
    weak var delegate: RadioButtonCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        radioCellButton .addTarget(self, action: "buttonClicked", forControlEvents :  UIControlEvents.TouchUpInside)
        
    }
    
    func buttonClicked () {
        delegate?.radioButtonCell?(self, didSelectOption: radioValueLabel.text!)
    }
    
}
