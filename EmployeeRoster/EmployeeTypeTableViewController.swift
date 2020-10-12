//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Sophie Kim on 2020/10/11.
//

import UIKit

class EmployeeTypeTableViewController: UITableViewController {
    var employeeType: EmployeeType?
}

extension EmployeeTypeTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension EmployeeTypeTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmployeeType.all.count
    
}
}

extension EmployeeTypeTableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTypeCell", for: indexPath)
        
        let type = EmployeeType.all[indexPath.row]
            cell.textLabel?.text = type.description()
        
        if employeeType == type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        employeeType = EmployeeType.all[indexPath.row]
        tableView.reloadData()
    }
}
