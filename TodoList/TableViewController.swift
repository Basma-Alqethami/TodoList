//
//  ViewController.swift
//  TodoList
//
//  Created by Basma Alqethami on 08/03/1443 AH.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, SaveButton {

    
    
    var items = [ToDoListItems]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! TableViewCell
                
        cell.Title.text = items[indexPath.row].titl
        cell.notes.text = items[indexPath.row].notes
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let strDate = dateFormatter.string(from: items[indexPath.row].date as! Date)
        cell.date.text = strDate
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        managedObjectContext.delete(items[indexPath.row])
        items.remove(at: indexPath.row)
        
        do {
            try managedObjectContext.save()
        } catch{
            print("\(error.localizedDescription)")
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
               if cell.accessoryType == .checkmark {
                   cell.accessoryType = .none
               } else {
                   cell.accessoryType = .checkmark
               }
           }
           tableView.deselectRow(at: indexPath, animated: true)
       }
    
    func fetchAllItems(){
        let itemRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoListItems")
        do {
            let results = try managedObjectContext.fetch(itemRequest)
            items = results as! [ToDoListItems]
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    
    func SaveButton(title: String, note: String, date: Date? ) {
        let item = ToDoListItems.init(context: managedObjectContext)
        item.titl = title
        item.notes = note
        item.date = date
        items.append(item)
        do{
            try managedObjectContext.save()
        } catch {
            print("\(error.localizedDescription)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "show" {
            let secondVC: AddItemsViewController = segue.destination as! AddItemsViewController
            secondVC.delegate = self
        }
    }
    
}

