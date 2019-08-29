//
//  SettingsViewController.swift
//  Random Interval Reaction Timer
//
//  Created by Ted Ganting Lim on 8/24/19.
//  Copyright © 2019 Jobless. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBAction func hitBack(sender: UIButton)
    {
        performSegue(withIdentifier: "cancelToViewController", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
