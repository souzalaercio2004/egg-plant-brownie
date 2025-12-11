//
//  NewItemViewController.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 06/12/25.
//

import UIKit

protocol AddAnItemDelegate{
    func addNew(item: Item)
}

class NewItemViewController: UIViewController {
    let delegate: AddAnItemDelegate?
    
    init(delegate: AddAnItemDelegate) {
        self.delegate = delegate
        super.init(nibName: "NewItemViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.delegate = nil
          super.init(coder: aDecoder)
      }
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var caloriesField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addNewItem() {
        if nameField == nil || caloriesField == nil {
            return
        }
        let name = nameField!.text
        //let calories: Double? = Double(caloriesField!.text!)
        let calories = NSString(string:  caloriesField.text!).doubleValue
        let item = Item(name: name!, calories: calories)
        if delegate == nil{
            return
        }
        delegate!.addNew(item: item)
        
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }

}
