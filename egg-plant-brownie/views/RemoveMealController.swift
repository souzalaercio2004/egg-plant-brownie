//
//  RemoveMealController.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 10/01/26.
//

import Foundation
import UIKit

class RemoveMealController {
    let controller: UIViewController
    init(controller: UIViewController){
        self.controller = controller
    }
    
    func show(meal: Meal, handler: (UIAlertAction) -> Void){
        let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: .alert)
        
        let remove = UIAlertAction(title: "Remove", style: .destructive)
        details.addAction(remove)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        details.addAction(cancel)
    
        controller.present(details, animated: true, completion: nil)
    }
}
