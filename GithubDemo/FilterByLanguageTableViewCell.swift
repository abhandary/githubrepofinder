//
//  FilterByLanguageTableViewCell.swift
//  GithubDemo
//
//  Created by Akshay Bhandary on 4/5/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit


@objc protocol FilterByLanguageTableViewCellDelegate {
    func switchValueChanged(sender: FilterByLanguageTableViewCell, value : Bool);
}

class FilterByLanguageTableViewCell: UITableViewCell {

    weak var delegate : FilterByLanguageTableViewCellDelegate?
    
    public var filterByLanguageState : Bool = false {
        didSet {
            self.filterByLanguageSwitch.isOn = filterByLanguageState
        }
    }
    
    @IBOutlet weak var filterByLanguageSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        self.delegate?.switchValueChanged(sender: self, value: sender.isOn);
    }
}
