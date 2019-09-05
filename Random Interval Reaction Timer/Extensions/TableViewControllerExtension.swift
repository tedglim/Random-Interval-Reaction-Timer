//
//  TableViewControllerExtension.swift
//  Random Interval Reaction Timer
//
//  Created by Ted Ganting Lim on 9/5/19.
//  Copyright © 2019 Jobless. All rights reserved.
//

import UIKit

extension UITableViewController {

    @objc private func dismissKeyboard() {
        tableView.endEditing(true)
    }
    
    public func closeKeyboardOnOutsideTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tap)
    }
}
