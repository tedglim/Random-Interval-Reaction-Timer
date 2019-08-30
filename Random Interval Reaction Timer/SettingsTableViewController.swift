//
//  SettingsTableViewController.swift
//  Random Interval Reaction Timer
//
//  Created by Ted Ganting Lim on 8/29/19.
//  Copyright © 2019 Jobless. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBAction func hitBack(sender: UIButton)
    {
        performSegue(withIdentifier: "cancelToViewController", sender: self)
    }
    
    let sectionTitles = ["S1", "S2", "S3"]
    let settingOptions1 = ["A","B","C"]
    let settingOptions2 = ["1","2","3","4"]
    let settingOptions3 = ["I", "U", "US"]
    
    let settingOptions = [
        ["A", "B", "C"],
        ["1", "2", "3", "4"],
        ["I", "U", "US"]]
    
    var keywords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.tableFooterView = UIView()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    //numSections
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitles.count
    }

    //numRowsPerSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return settingOptions1.count
        case 1:
            return settingOptions2.count
        case 2:
            return settingOptions3.count
        default:
            return -1
        }
        // #warning Incomplete implementation, return the number of rows
        
    }

    //titlePerSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    //addContent
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)

        // Configure the cell...
        switch (indexPath.section) {
        case 0:
            cell.textLabel?.text = settingOptions1[indexPath.row]
        case 1:
            cell.textLabel?.text = settingOptions2[indexPath.row]
        case 2:
            cell.textLabel?.text = settingOptions3[indexPath.row]
        default: break
        }

        return cell
    }

    //select&deselect row checkmark
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
            } else {
                cell.accessoryType = .checkmark
            }
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
