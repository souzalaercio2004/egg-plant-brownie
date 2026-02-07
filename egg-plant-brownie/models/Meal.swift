//
//  Meal.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 30/11/25.
//

import Foundation

class Meal {
    let name: String
    let happiness: Int
    var items = Array<Item>()
    
    init(name: String, happiness: Int) {
        self.name = name
        self.happiness = happiness
    }
    
    func allCalories() -> Double{
        print("Calculating...")
        var total = 0.0
        for i in items {
            total += i.calories
        }
        return total
    }
    func details() -> String{
        var message = ("Happiness:  \(self.happiness)")
        for item in self.items {
            message += "\n  \(item.name) - calories: \(item.calories)"
        }
        return message
    }
}
