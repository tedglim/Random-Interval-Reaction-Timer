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
    
    //onViewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSettings()
        self.clearsSelectionOnViewWillAppear = false
        tableView.tableFooterView = UIView()
    }
    
    //marks selected rows on segue back to settingsVC
    func checkSettings() {
        for setting in selectedOptions {
            if setting.isSelected {
                let path = IndexPath.init(row: setting.row, section: setting.section)
                self.tableView.selectRow(at: path, animated: false, scrollPosition: .none)
                self.tableView.cellForRow(at: path)?.accessoryType = .checkmark
            }
        }
    }

    //numSections
    override func numberOfSections(in tableView: UITableView) -> Int {
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
    }

    //titlePerSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    //addContent
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
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

    //select&deselect row checkmark; selected to storage array
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    }

    //perform segue on back button press
    @IBAction func hitBack(sender: UIButton)
    {
        performSegue(withIdentifier: "cancelToViewController", sender: self)
    }
    
    //store chosen settings and pass to VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cancelToViewController" {
            let vc = segue.destination as! ViewController
            vc.passedOptions = selectedOptions
        }
    }
}
