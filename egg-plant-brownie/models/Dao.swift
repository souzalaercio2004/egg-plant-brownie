//
//  Dao.swift
//  egg-plant-brownie
//
//  Created by LAERCIO DE SOUZA on 24/02/26.
//

import Foundation

class Dao{
    let mealsArchive: String
    let itemsArchive: String
    
    init() {
        let userDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = userDir[0] as String
        mealsArchive = "\(dir) eggplant-brownie-meals"
        itemsArchive = "\(dir) eggplant-brownie-items"
    }
    // Supondo que Meal e Item conformem a Codable
    func saveMeals(meals: Array<Meal>){
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(meals)
                let url = URL(fileURLWithPath: mealsArchive)
                try data.write(to: url)
            } catch {
                print("Erro ao salvar meals: \(error)")
            }
    }

    func saveItems(items: Array<Item>){
            let encoder = PropertyListEncoder()
            do {
                let data = try encoder.encode(items)
                let url = URL(fileURLWithPath: itemsArchive)
                try data.write(to: url)
            } catch {
                print("Erro ao salvar items: \(error)")
            }
    }

    // Helpers para obter o URL de arquivo (exemplo usando documentos)
    func mealsArchiveURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("meals.archive")
    }

    func itemsArchiveURL() -> URL {
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documents.appendingPathComponent("items.archive")
    }
    
    func loadMeals() -> [Meal] {
        let url = URL(fileURLWithPath: mealsArchive)
           guard FileManager.default.fileExists(atPath: url.path) else { return [] }
           do {
               let data = try Data(contentsOf: url)
               let decoder = PropertyListDecoder()
               return try decoder.decode([Meal].self, from: data)
           } catch {
               print("Persistence loadMeals error: \(error)")
               return []
           }
       }

       func loadItems() -> [Item] {
           let url = URL(fileURLWithPath: itemsArchive)
           guard FileManager.default.fileExists(atPath: url.path) else { return [] }
           do {
               let data = try Data(contentsOf: url)
               let decoder = PropertyListDecoder()
               return try decoder.decode([Item].self, from: data)
           } catch {
               print("Persistence loadItems error: \(error)")
               return []
           }
       }
}

