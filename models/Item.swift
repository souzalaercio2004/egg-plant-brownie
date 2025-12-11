//
//  Item.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 30/11/25.
//

import Foundation

<<<<<<< HEAD
class Item{
=======
class Item: Equatable{
  
    
>>>>>>> 341b009 (Acertando o repositorio em 09/12/2025)
    let name: String
    let calories: Double
    init(name: String, calories: Double) {
        self.name = name
        self.calories = calories
    }
}
<<<<<<< HEAD
=======

func == (first: Item, second: Item) -> Bool {
    return first.name == second.name && first.calories == second.calories
}
>>>>>>> 341b009 (Acertando o repositorio em 09/12/2025)
