//
//  ViewController.swift
//  Random Interval Reaction Timer
//
//  Created by Ted Ganting Lim on 8/23/19.
//  Copyright © 2019 Jobless. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var timerPicker: UIPickerView!
    var timerPickerData: [[String]] = [[String]]()

    //number of columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //number of rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 60
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timerPickerData[component][row]
    }
    
    // Capture the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.timerPicker.delegate = self
        self.timerPicker.dataSource = self
        
        timerPickerData = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "29", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60"],
        ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "29", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60"]]
    }
    
    @IBAction func cancelToViewController(_ unwindSegue: UIStoryboardSegue)
    {}
    
    @IBAction func hitStart(sender: UIButton)
    {
        print("Start")
    }
    
    @IBAction func hitCancel(sender: UIButton)
    {
        print("Cancel")
    }
    
    @IBAction func hitSettings(sender: UIButton)
    {
        print("Settings")
    }
}