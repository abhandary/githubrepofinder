//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!

    var selectedLanguages = [false, false, false, false, false, false];
    var languages = ["Java", "JavaScript", "Objective-C", "Python", "Ruby", "Swift"];
    var numberOfStarsFilter  : Int = 0
    var filterByLanguage : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // setup table view
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 120
        self.automaticallyAdjustsScrollViewInsets = false;
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                print(repo)
            }
            
            self.repos = newRepos
            self.tableView.reloadData()

            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repos?.count ?? 0;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! GitRepoTableViewCell;
        cell.githubRepo = self.repos[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130;
    }
    

    @IBAction func unwindSettings(segue : UIStoryboardSegue) {
        if segue.identifier == "saveSegue",
            let source = segue.source as? SettingsViewController {
            
            // cache preferences
            self.languages = source.languages;
            self.filterByLanguage = source.filterByLanguage
            self.numberOfStarsFilter = source.numberOfStarsFilter
            self.selectedLanguages = source.selectedLanguages
            
            // apply to search settings
            searchSettings.minStars = self.numberOfStarsFilter
            searchSettings.languageFilter = self.filterByLanguage
            searchSettings.selectedLanguages = self.selectedLanguages
            
            // search
            doSearch()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettingsSegue",
            let destination = segue.destination as? UINavigationController,
            let settingsVc  = destination.topViewController as? SettingsViewController  {
            
            // passthrough cached preferences
            settingsVc.languages = self.languages;
            settingsVc.filterByLanguage = self.filterByLanguage
            settingsVc.numberOfStarsFilter = self.numberOfStarsFilter
            settingsVc.selectedLanguages = self.selectedLanguages
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true);
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}
