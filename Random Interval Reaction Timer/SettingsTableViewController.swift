//
//  SettingsTableViewController.swift
//  Random Interval Reaction Timer
//
//  Created by Ted Ganting Lim on 8/29/19.
//  Copyright © 2019 Jobless. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    //inits
    let sectionTitles = ["Words", "Color", "TBD"]
    let settingOptions1 = ["move_backward","move_forward","move_left", "move_right"]
    let settingOptions2 = ["red", "blue", "purple", "cyan", "orange"]
    let settingOptions3 = ["1","2","3","4"]
    struct Options {
        var isSelected = false
        var isSound = false
        var isColor = false
        var text = ""
        var section = -1
        var row = -1
    }
    var selectedOptions = [Options]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSettings()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        
        tableView.tableFooterView = UIView()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func checkSettings() {
        print(selectedOptions)
        for setting in selectedOptions {
            if setting.isSelected {
                let path = IndexPath.init(row: setting.row, section: setting.section)
                self.tableView.selectRow(at: path, animated: false, scrollPosition: .none)
                self.tableView.cellForRow(at: path)?.accessoryType = .checkmark
            }
        }
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
//        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                let index = selectedOptions.firstIndex(where: { $0.section == indexPath.section && $0.row == indexPath.row })
                selectedOptions.remove(at: index!)
            } else {
                var option = Options(
                    isSelected: true, isSound: false, isColor: false, text: cell.textLabel!.text!, section: indexPath.section, row: indexPath.row)
                if indexPath.section == 1 {
                    option.isColor = true
                } else {
                    option.isSound = true
                }
                cell.accessoryType = .checkmark
                selectedOptions.append(option)
            }
        }
        print(selectedOptions)
    }

    @IBAction func hitBack(sender: UIButton)
    {
        performSegue(withIdentifier: "cancelToViewController", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cancelToViewController" {
            print("cancel to view controller from Settings")
            let vc = segue.destination as! ViewController
            vc.passedOptions = selectedOptions
            print("These are passed options: \(vc.passedOptions)")
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
