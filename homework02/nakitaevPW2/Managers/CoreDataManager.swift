//
//  CoreManager.swift
//  nakitaevPW2
//
//  Created by Никита Китаев on 19.03.2024.
//

import UIKit
import CoreData

// MARK: - CRUD
public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func createWish(_ id: Int16, text: String) -> Wish? {
        guard let wishEntityDescription = NSEntityDescription.entity(forEntityName: "Wish", in: context) else {
            return nil
        }
        
        let wish = Wish(entity: wishEntityDescription, insertInto: context)
        wish.id = id
        wish.text = text
        
        appDelegate.saveContext()
        
        return wish
    }
    
    public func fetchWishes() -> [Wish] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        
        do {
            return (try? context.fetch(fetchRequest) as? [Wish]) ?? []
        }
    }
    
    public func fetchWish(_ id: Int16) -> Wish? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        
        do {
            guard let wishes = try? context.fetch(fetchRequest) as? [Wish] else { return nil }
            
            return wishes.first(where: { $0.id == id })
        }
    }
    
    public func updateWish(with id: Int16, newText: String) -> Wish? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        
        do {
            guard let wishes = try? context.fetch(fetchRequest) as? [Wish],
                  let wish = wishes.first(where: { $0.id == id }) else { return nil }
            
            wish.text = newText
            
            appDelegate.saveContext()
            
            return wish
        }
    }
    
    public func deleteWish(with id: Int16) -> Wish? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Wish")
        
        do {
            guard let wishes = try? context.fetch(fetchRequest) as? [Wish],
                  let wish = wishes.first(where: { $0.id == id }) else { return nil }
            
            context.delete(wish)
            
            appDelegate.saveContext()
            
            return wish
        }
    }
}
