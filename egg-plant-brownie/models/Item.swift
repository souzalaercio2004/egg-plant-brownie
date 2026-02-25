//
//  Item.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 30/11/25.
//

import Foundation

class Item: NSObject, NSCoding, Codable{
   
    let name: String
    let calories: Double
    init(name: String, calories: Double) {
        self.name = name
        self.calories = calories
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "name") as? String else { return nil }
        self.name = name
        self.calories = aDecoder.decodeDouble(forKey: "calories")
    }
    
    func encode(with acoder: NSCoder) {
        acoder.encode(name, forKey: "name")
        acoder.encode(calories, forKey: "calories")
    }
    
}

func == (first: Item, second: Item) -> Bool {
    return first.name == second.name && first.calories == second.calories
}
