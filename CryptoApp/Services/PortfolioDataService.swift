//
//  PortfolioDataService.swift
//  CryptoApp
//
//  Created by MacBook on 12/11/2024.
//

import Foundation
import CoreData

//protocol PortfolioDataProtocol {
//    
//    func save(id: String, amount: Double) -> Void
//    
//    func get() -> Void
//    
//    func remove(portfolio: PortfolioEntity) -> Void
//    
//    func update(portfolio: PortfolioEntity, newAmount: Double) -> Void
//    
//}

class PortfolioDataService: ObservableObject {
 
    @Published var portfolio: [PortfolioEntity] = []
    
    private let containerName: String = "PortfolioContainer"
    
    private let entityName: String = "PortfolioEntity"
    
    private let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error loading core data \(error)")
            } else {
                self.get()
                print ("Successfully loaded core data!")
            }
        }
    }
    
    // MARK: PUBLIC
    
    func updatePortfolio(id: String , amount: Double) -> Void {
        if let entity = portfolio.first(where: {$0.coinId == id}) {
            if amount > 0 {
                update(portfolio: entity, newAmount: amount)
            } else {
                delete(portfolio: entity)
            }
        } else {
            create(id: id, amount: amount)
        }
    }
    
    
    // MARK: PRIVATE
    
    private func create(id: String, amount: Double) -> Void {
        let portfolio = PortfolioEntity(context: container.viewContext)
        
        portfolio.coinId = id
        portfolio.amount = amount
        
        applyChanges()
    }
    
    private func get() -> Void {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        
        do {
            portfolio = try container.viewContext.fetch(request)
        } catch {
            print("error during fetch PortfolioEntity data \(error)")
        }
    }
    
    private func save() -> Void {
        do {
            try container.viewContext.save()
        } catch {
            print("error during saving data \(error)")
        }
    }
    
    private func delete(portfolio: PortfolioEntity) -> Void {
        container.viewContext.delete(portfolio)
        applyChanges()
    }
    
    
    private func update(portfolio: PortfolioEntity, newAmount: Double) {
        portfolio.amount = newAmount
        applyChanges()
    }
    
    private func applyChanges() -> Void {
        save()
        get()
    }
}
