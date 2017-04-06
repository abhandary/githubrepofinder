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
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ownerHandle: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var forks: UILabel!
    
    
    public var githubRepo : GithubRepo! {
        didSet {
            populateCell()
        }
    }
    
    func populateCell() {
        if let avatarURL = self.githubRepo.ownerAvatarURL,
            let url = URL(string: avatarURL)  {
            self.avatarImage.setImageWith(URLRequest(url: url), placeholderImage: nil,
                                          success:{ (imageRequest, imageResponse, image) -> Void in
                                            
                                            // imageResponse will be nil if the image is cached
                                            if imageResponse != nil {

                                                self.avatarImage?.alpha = 0.0
                                                self.avatarImage?.image = image
                                                self.avatarImage?.contentMode = UIViewContentMode.scaleToFill
                                                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                                                    self.avatarImage?.alpha = 1.0
                                                })
                                            } else {

                                                self.avatarImage?.image = image
                                                self.avatarImage?.contentMode = UIViewContentMode.scaleToFill
                                            }
                },failure: { (imageRequest, imageResponse, error) -> Void in
                    
            })
                
                // .setImageWith(url)
        }
        
        if let name = self.githubRepo.name {
            self.name.text = name
        }
        
        if let ownerHandle = self.githubRepo.ownerHandle {
            self.ownerHandle.text = ownerHandle
        }
        
        if let stars = self.githubRepo.stars {
            self.stars.text = String(stars)
        }
        
        if let forks = self.githubRepo.forks {
            self.forks.text = String(forks);
        }
        
        if let repoDescription = self.githubRepo.repoDescription {
            self.repoDescription.text = repoDescription
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
