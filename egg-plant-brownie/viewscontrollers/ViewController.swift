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
    
    
    var items = [
        Item(name: "Eggplant Brownie", calories: 10),
        Item(name: "Zucchini Mufin", calories: 10),
        Item(name: "Coconut oil", calories: 500),
        Item(name: "Chocolate Frosting", calories: 1000),
        Item(name: "Chocolate Chip", calories: 100)]
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var happinessField: UITextField!
    var delegate: AddMealDelegate?
    var selected = Array<Item>()
    
    @IBOutlet var tableView: UITableView!
    
    
    func addNew(item: Item){
        items.append(item)
        if let table = tableView{
            table.reloadData()
        } else {
            Alert(controller: self).show(message: "Unespected error, but the item was added.")
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
    
    override func viewDidLoad() {
        let newItemButton = UIBarButtonItem(title: "new item", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.showNewItem))
        
        newItemButton.tintColor = UIColor.blue
        
        navigationItem.rightBarButtonItem = newItemButton
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
    
    @IBAction func showNewItem() {
        let newItem = NewItemViewController(delegate: self)
        
        if let navigation = navigationController {
            navigation.pushViewController(newItem, animated: true)
        }
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

