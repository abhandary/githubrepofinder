//
//  MinimumStarsTableViewCell.swift
//  GithubDemo
//
//  Created by Akshay Bhandary on 4/5/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

@objc protocol MinimumStarsTableViewCellDelegate {
    func starsDidChange(sender : MinimumStarsTableViewCell, value : Int);
}

class MinimumStarsTableViewCell: UITableViewCell {

    @IBOutlet weak var startsSlider: UISlider!
    @IBOutlet weak var starsLabel: UILabel!
    
    weak var delegate : MinimumStarsTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.startsSlider.maximumValue = 5;
        self.startsSlider.minimumValue = 0;
        self.startsSlider.value = 5;
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.starsLabel.text = String(Int(sender.value))
        self.delegate?.starsDidChange(sender: self, value: Int(sender.value))
    }
}
