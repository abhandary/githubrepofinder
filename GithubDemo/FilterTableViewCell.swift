//
//  FilterTableViewCell.swift
//  GithubDemo
//
//  Created by Akshay Bhandary on 4/5/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

@objc protocol FilterTableViewCellDelegate {
    func selected(sender : FilterTableViewCell, state : Bool)
}

class FilterTableViewCell: UITableViewCell {

    weak var delegate : FilterTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        if self.accessoryType == .checkmark {
//            self.accessoryType = .none;
//        } else {
//            self.accessoryType = .checkmark
//        }
        
        //self.delegate?.selected(sender: self, state: self.accessoryType == .checkmark);
    }

}
