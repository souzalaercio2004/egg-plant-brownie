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

class NewItemViewController: UIViewController{
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
    
    var  items = Array<Item>()

    private let archiveURL: URL = {
          let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
          return documents.appendingPathComponent("items.archive")
      }()
    
    func getUserDir()-> URL {
        let userDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return userDir[0]
    }
    
    func add(item: Item){
        items.append(item)
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: items, requiringSecureCoding: false)
            try data.write(to: archiveURL)
        } catch {
            print("Failed to archive items: \(error)")
        }
        //tableView.reloadData()
    }

    override func viewDidLoad() {
        let dir = getUserDir()
        let archive = "\(dir)/egg-plant-brownie-Items"
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: archive))
            
            if let loaded = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [NSArray.self, Item.self], from: data) as? [Item] {
                self.items = loaded
            } else {
                self.items = []
            }
        } catch {
            // Handle file not found or decoding errors gracefully
            self.items = []
            // Optionally log: print("Failed to load items: \(error)")
        }
    }
    
    @IBAction func addNewItem(_ sender: UIButton) {
        if nameField == nil || caloriesField == nil {
            return
        }
        let name = nameField!.text
        
        let calories = NSString(string:  caloriesField.text!).doubleValue
        let item = Item(name: name!, calories: calories)
        if delegate == nil{
            return
        }
        delegate?.addNew(item: item)
        
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
        
    }
        
}

