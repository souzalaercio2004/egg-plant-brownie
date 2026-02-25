//
//  ViewController.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 30/11/25.
//

import UIKit

protocol AddMealDelegate {
    func add(meal: Meal)
}

class ViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate , AddAnItemDelegate{
    
    
    var items = Array<Item>()
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var happinessField: UITextField!
    var delegate: AddMealDelegate?
    var selected = Array<Item>()
    
    @IBOutlet var tableView: UITableView!
    
    
    func addNew(item: Item){
        items.append(item)
        Dao().saveItems(items: items)
        if let table = tableView {
            table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = items[row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = item.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell == nil{
            return
        }
        if cell!.accessoryType == UITableViewCell.AccessoryType.none{
            cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
            selected.append(items[indexPath.row])
        }else{
            cell?.accessoryType = UITableViewCell.AccessoryType.none
            //remove
            if let position = selected.firstIndex(of: items[indexPath.row]) {
                selected.remove(at: position)
            }
        }
    }
    
    var meals = Array<Meal>()
    
    override func viewDidLoad() {
        
        // Obtém o diretório de documentos (Swift moderno, mas mantendo NSKeyedArchiver)
        _ = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let dir = getUserDir()
        let archivePath = (dir as NSString).appendingPathComponent("egg-plant-brownie-meals")
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: archivePath))
            // If Meal is a class that conforms to NSSecureCoding:
            if let loaded = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Meal.self], from: data) as? [Meal] {
                self.meals = loaded
            } else {
                self.meals = []
            }
        } catch {
            // Handle file not found or decoding errors gracefully
            self.meals = []
            // Optionally log: print("Failed to load meals: \(error)")
        }
        
        let newItemButton = UIBarButtonItem(title: "new item", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.showNewItem))
        newItemButton.tintColor = UIColor.blue
        
        navigationItem.rightBarButtonItem = newItemButton
        items = Dao().loadItems()
    }
    
    
    
    @IBAction func add(_ sender: UIButton) {
        if let meal = getMealFromForm() {
            if let meals = delegate{
                meals.add(meal: meal)
                if let navigation = self.navigationController {
                    navigation.popViewController(animated: true)
                }else {
                    Alert(controller: self).show(message: "Unexpected error, but the view was added.")
                }
                return
            }
        }
        Alert(controller: self).show()
        
    }
    
    func getUserDir() -> String {
        let userDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        return userDir[0] as String
    }

    @IBAction func showNewItem() {
        let newItem = NewItemViewController(delegate: self)
        
        if let navigation = navigationController {
            navigation.pushViewController(newItem, animated: true)
        } else {
            Alert(controller: self).show()
        }
        tableView.reloadData()
    }
    
    func getMealFromForm() -> Meal? {
        if (nameField.text == nil  || happinessField.text == nil) {
            return nil
        }
        let name = nameField.text!
        let happiness = Int(happinessField.text!)
        if happiness == nil {
            return nil
        }
        
        let meal =  Meal(name: name, happiness: happiness!)
        meal.items = selected
        print("eaten: \(meal.name) \(meal.happiness) \(meal.items) ")
        return meal
    }
}

