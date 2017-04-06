//
//  GitRepoTableViewCell.swift
//  GithubDemo
//
//  Created by Akshay Bhandary on 4/5/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class GitRepoTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImage: UIImageView!
    
    public var githubRepo : GithubRepo! {
        didSet {
            populateCell()
        }
    }
    
    func populateCell() {
        if let avatarURL = self.githubRepo.ownerAvatarURL,
            let url = URL(string: avatarURL)  {
            self.avatarImage.setImageWith(url)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
