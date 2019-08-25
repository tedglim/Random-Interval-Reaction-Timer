//
//  ViewController.swift
//  Random Interval Reaction Timer
//
//  Created by Ted Ganting Lim on 8/23/19.
//  Copyright © 2019 Jobless. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    @IBAction func cancelToViewController(_ unwindSegue: UIStoryboardSegue)
    {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
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
