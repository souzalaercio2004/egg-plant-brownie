//
//  Meal.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 30/11/25.
//

import Foundation

class Meal: NSObject, NSCoding, Codable {
    
    let name: String
    let happiness: Int
    var items = Array<Item>()
    
    init(name: String, happiness: Int) {
        self.name = name
        self.happiness = happiness
    }
    
    required init(coder aDecoder: NSCoder){
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.happiness = aDecoder.decodeInteger(forKey: "happiness")
        self.items = aDecoder.decodeObject(forKey: "items") as! Array<Item>
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
    
    func encode(with coder: NSCoder) {
        coder.encode(self.name, forKey: "name")
        coder.encode(self.happiness, forKey: "happiness")
        coder.encode(self.items, forKey: "items")
    }
}
