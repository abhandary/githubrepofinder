//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Akshay Bhandary on 4/5/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MinimumStarsTableViewCellDelegate, FilterByLanguageTableViewCellDelegate, FilterTableViewCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    public var selctedLanguages = [false, false, false, false, false, false];
    var languages = ["Java", "JavaScript", "Objective-C", "Python", "Ruby", "Swift"];
    public var numberOfStarsFilter  : Int = 5
    public var filterByLanguage : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1;
        default:
            return 1 + (filterByLanguage == false ? 0 : self.languages.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "MinimumStarsTableViewCell") as! MinimumStarsTableViewCell;
            cell.starsLabel.text = String(self.numberOfStarsFilter);
            cell.delegate = self
            return cell;
        }
        if indexPath.row == 0 {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "FilterByLanguageTableViewCell") as! FilterByLanguageTableViewCell;
            cell.filterByLanguageState = self.filterByLanguage
            cell.delegate = self;
            return cell;
        }
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FilterTableViewCell") as! FilterTableViewCell;
        cell.textLabel?.text = self.languages[indexPath.row - 1];
        cell.accessoryType = self.selctedLanguages[indexPath.row - 1] == true ? .checkmark : .none
        cell.delegate = self;
        return cell;
    }
    
    // MARK: - FilterByLanguageTableViewCellDelegate
    func switchValueChanged(sender: FilterByLanguageTableViewCell, value : Bool) {
        self.filterByLanguage = value;
        self.tableView.reloadData()
    }
    
    // MARK: - MinimumStarsTableViewCellDelegate
    func starsDidChange(sender : MinimumStarsTableViewCell, value : Int) {
        self.numberOfStarsFilter = value;
    }
    
    // MARK: - FilterTableViewCellDelegate
    func selected(sender : FilterTableViewCell, state : Bool) {
        self.selctedLanguages[self.tableView.indexPath(for: sender)!.row - 1] = state
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let cell = self.tableView.cellForRow(at: indexPath) as! FilterTableViewCell;
            cell.accessoryType = cell.accessoryType == .checkmark ? .none : .checkmark;
            if indexPath.row > 0 {
                self.selctedLanguages[indexPath.row - 1] = (cell.accessoryType == .checkmark ? true : false)
                // self.tableView.reloadData()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
