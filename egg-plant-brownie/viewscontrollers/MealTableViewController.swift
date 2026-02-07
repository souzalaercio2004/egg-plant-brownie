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
    var selectedMeal: Meal?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = indexPath.row
        let meal = meals[row]       
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = meal.name
        
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector(("showDetails:")))
        longPress.minimumPressDuration = 1.0
        cell.addGestureRecognizer(longPress)
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
    
    
    func show(meal: Meal, handler: ((UIAlertAction) -> Void)? = nil) {
        let detais = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: .alert)
        let remove = UIAlertAction(title: "Remove", style: .destructive, handler: handler)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        detais.addAction(remove)
        detais.addAction(ok)
        present(detais, animated: true, completion: nil)
    }
    
    func showDetails(reconizer: UILongPressGestureRecognizer){
        if reconizer.state == UILongPressGestureRecognizer.State.began{
            let cell = reconizer.view as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            if indexPath == nil{
                return
            }
            let row = indexPath!.row
            let meal = meals[row]
            
           
            RemoveMealController(controller: self).show(meal: meal, handler: {
                action in
                self.meals.remove(at: row)
                self.tableView.reloadData()})
        }
        
    }
    
   
}

 
