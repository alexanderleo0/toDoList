//
//  ViewController.swift
//  toDoList
//
//  Created by Александр Никитин on 20.08.2018.
//  Copyright © 2018 Александр Никитин. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    //массив с записями, для их передачи в списки
    var itemArray = [Items]()
    
    // Создали путь для сохранения всей информации
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        loadItems()

//        let newItem = Items()
//        newItem.title = "Find Miky"
//        itemArray.append(newItem)
        
    }

    //MARK - TableView Data Source Methods
    //количество строк
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //Создаем ячейку (cell)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCellIdentifier", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none
        return cell
    }

    
    //MARK - TableView Delegate Methods
    //Реакция на клик по ячейке (выбор ячейки)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // снимаем/ставим галочку о выполнении
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        // чисто для красоты, что бы не висело серым
        tableView.deselectRow(at: indexPath, animated: true)
        // сохраняем в данные
        saveItems()
        
    }
    
    @IBAction func addRow(_ sender: Any) {
        
        var textF = UITextField()
        
        let allert = UIAlertController(title: "Add todoList", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (act) in
            let newItem = Items()
            newItem.title = textF.text!
            self.itemArray.append(newItem)
            self.saveItems()
          //  self.defaults.set(self.itemArray, forKey: "TodoListArray")
        }
        
        allert.addAction(action)
        allert.addTextField { (textField) in
            textField.placeholder = "Write your action"
            textF = textField
        }
    
        present(allert, animated: true, completion: nil)
    }
    
    
    func saveItems() {
        
        //переводит данные в plist
        let encoder = PropertyListEncoder()
        do {
            // переводим данные в plist
            let data = try encoder.encode(itemArray)
            // пробуем их записать
            try data.write(to: dataFilePath!)
        } catch {
            // Если не получилось выводим ошибку
            print ("\(error)")
        }
        //перезагружаем таблицу
        self.tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
          do {
            itemArray = try decoder.decode([Items].self, from: data)
                //  itemArray = try decoder.decode([Items].self, from: data)
            } catch {
                print(error)
           
            }
        }
    }
    
}

