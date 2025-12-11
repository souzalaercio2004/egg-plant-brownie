//
//  ViewController.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 30/11/25.
//

import UIKit

<<<<<<< HEAD
class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    
    @IBOutlet weak var hapinnessTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addPrerssed(_ sender: UIButton) {
        if (nameTextField.text == nil  || hapinnessTextField.text == nil) {
            
            print ("Error: invalid values")
            return
        }
        let name = nameTextField.text
        let hapinness: Int = Int(hapinnessTextField.text! )!
        
       
        print("eaten: \(String(describing: name)) - \(hapinness)")
=======
protocol AddMealDelegate {
    func add(meal: Meal)
}

class ViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {
    
    var items = [
        Item(name: "Eggplant Brownie", calories: 10),
        Item(name: "Zucchini Mufin", calories: 10),
        Item(name: "Coconut oil", calories: 500),
        Item(name: "Chocolate Frosting", calories: 1000),
        Item(name: "Chocolate Chip", calories: 100)]
    var selected = Array<Item>()
    
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
    
    @IBOutlet var tableView: UITableView!
    
    func addNew(item: Item) {
        items.append(item)
        if tableView == nil{
            return
        }
        tableView.reloadData()
        
    }
    

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var hapinnessTextField: UITextField!
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        let newItemButton = UIBarButtonItem(title: "new item", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.showNewItem))
        
        navigationItem.rightBarButtonItem = newItemButton
    }
    
    var delegate: AddMealDelegate?
    
    @IBAction func add(_ sender: UIButton) {
        if (nameTextField.text == nil  || hapinnessTextField.text == nil) {
            print ("Error: invalid values")
            return
        }
        let name = nameTextField.text!
        let hapinness: Int = Int(hapinnessTextField.text! )!
        let meal =  Meal(name: name, happiness: hapinness)
        meal.items = selected
        
        print("eaten: \(String(describing: meal.name)), \(meal.happiness), \(meal.items)")
        
        if delegate == nil {
            return
        }
        delegate?.add(meal: meal)
        
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    @IBAction func showNewItem(){
        let newItem = NewItemViewController(delegate: self)
        if let navigagaion = navigationController {
            navigagaion.pushViewController(newItem, animated: true)
        }
>>>>>>> 341b009 (Acertando o repositorio em 09/12/2025)
    }
    
}

