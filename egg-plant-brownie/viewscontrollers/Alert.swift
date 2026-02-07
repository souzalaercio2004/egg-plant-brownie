//
//  Alert.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 28/12/25.
//
import UIKit

class Alert{
    var controller = UIViewController()
    init(controller: UIViewController){
        self.controller = controller
    }
    func show(message: String = "Unexpected error."){
        let details = UIAlertController(title: "Sorry", message: message, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Understold", style: .cancel, handler: nil)
        details.addAction(cancel)
        controller.present(details, animated: true, completion: nil)
    }
}
