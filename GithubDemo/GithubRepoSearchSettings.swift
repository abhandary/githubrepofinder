//
//  GithubRepoSearchSettings.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import Foundation

// Model class that represents the user's search settings
class GithubRepoSearchSettings {
    var searchString: String?
    var minStars = 0
    
    var selectedLanguagesStr : String = "";
        var languages = ["Java", "JavaScript", "Objective-C", "Python", "Ruby", "Swift"];
    
    var languageFilter : Bool = false
    
    var selectedLanguages = [false, false, false, false, false, false] {
        didSet {
            if languageFilter == true {
                selectedLanguagesStr = ""
                for ix in 0..<self.languages.count {
                    if selectedLanguages[ix] == true {
                        selectedLanguagesStr += "language:" + languages[ix] + (ix < self.languages.count - 1 ? " " : "")
                    }
                }
            }
        }
    }
    
    
    init() {
        
    }
}
