//
//  MealTableViewController.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 30/11/25.
//

import UIKit

class MealTableViewController: UITableViewController, AddMealDelegate {
    var meals = [Meal(name: "Eggplant Brownie", happiness: 5),
                 Meal(name: "Zuchinni Muffin", happiness: 3)]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let meal = meals[row]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = meal.name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addMeal" {
            let view = segue.destination as! ViewController
            view.delegate = self
        }
        
    }
    func add(meal: Meal){
        meals.append(meal)
        tableView.reloadData()
    }
}
