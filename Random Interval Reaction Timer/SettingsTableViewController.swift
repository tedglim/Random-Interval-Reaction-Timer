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
    let sectionTitles = ["Words", "Color", "Timer Options"]
    let settingOptions1 = ["forward","backward","right", "left", "1", "2", "3", "4"]
    let settingOptions2 = ["red", "blue", "purple", "cyan", "orange"]
    
    struct Options {
        var isSelected = false
        var isSound = false
        var isColor = false
        var text = ""
        var section = -1
        var row = -1
    }
    var selectedOptions = [Options]()
    
    var defStr = ""
    var intervalField = 1
    var defInt = 1
    var freqField = 10
    var defFreq = 10
    var defFreqStr = "10"

    
    //onViewLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSettings()
        self.closeKeyboardOnOutsideTap()
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
            return 2
        default:
            return -1
        }
    }

    //titlePerSection
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    //addContent; fills timer options settings on add content phase
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell01 = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        switch (indexPath.section) {
        case 0:
            cell01.textLabel?.text = settingOptions1[indexPath.row]
        case 1:
            cell01.textLabel?.text = settingOptions2[indexPath.row]
        case 2:
            let cell02 = tableView.dequeueReusableCell(withIdentifier: "numInputCell", for: indexPath) as! numInputTableViewCell
            if indexPath.row == 0 {
                cell02.numLabel.text = "Min Interval (sec)"
                cell02.numInputField.placeholder = "Enter Value"
                cell02.numInputField.text = String(intervalField)
                cell02.selectionStyle = UITableViewCell.SelectionStyle.none
            } else if indexPath.row == 1 {
                cell02.numLabel.text = "Frequency"
                cell02.numInputField.placeholder = "1 - 10"
                cell02.numInputField.text = String(freqField)
                cell02.selectionStyle = UITableViewCell.SelectionStyle.none
            }
            return cell02
        default: break
        }
        return cell01
    }

    //select&deselect row checkmark; selected to storage array
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                cell.isSelected = false
                cell.isHighlighted = false
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

    //make cells with no selection unselectable
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = tableView.cellForRow(at: indexPath as IndexPath)
        if(cell?.selectionStyle == UITableViewCell.SelectionStyle.none){
            return nil;
        }
        return indexPath
    }
    
    //records values of edited textfields
    @IBAction func numInputEditingDidEnd(_ sender: UITextField) {
        if sender.placeholder == "Enter Value" {
            //store value as minInterval
            if let tmpTxt = sender.text {
                intervalField = Int(tmpTxt) ?? defInt
            } else {
                intervalField = defInt
            }
        } else if sender.placeholder == "1 - 10" {
            if let tmpTxt = sender.text {
                freqField = Int(tmpTxt) ?? defFreq
            } else {
                freqField = defFreq
            }
            if freqField > 10 || freqField <= 0 {
                sender.text = defFreqStr
                freqField = defFreq
            }
        }
    }
    
    //store chosen settings and pass to VC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cancelToViewController" {
            let vc = segue.destination as! ViewController
            vc.passedOptions = selectedOptions
            vc.minInterval = intervalField
            vc.frequency = freqField
            print("FROM SETTINGS")
            print("These are passed options:")
            print(vc.passedOptions)
            print("Min Interval")
            print(vc.minInterval)
            print("Frequency")
            print(vc.frequency)
        }
    }
}
