//
//  ViewController.swift
//  toDoList
//
//  Created by Александр Никитин on 20.08.2018.
//  Copyright © 2018 Александр Никитин. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = ["Find Mike", "Buy Eggs", "Destroy World"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //MARK - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCellIdentifier", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]

        return cell
    }

    
    //MARK - TableView Delegate Methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    @IBAction func addRow(_ sender: Any) {
        
        var textF = UITextField()
        
        let allert = UIAlertController(title: "Add todoList", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (act) in
            self.itemArray.append(textF.text!)
            self.tableView.reloadData()
        }
        
        allert.addAction(action)
        allert.addTextField { (textField) in
            textField.placeholder = "Write your action"
            textF = textField
        }
    
        present(allert, animated: true, completion: nil)
    }
    
    
    
    
}

