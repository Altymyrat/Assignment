//
//  CoreDataManager.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 17.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() { }
    
    
    // MARK: - Properties
    lazy var managedObject: NSManagedObjectModel = {
        guard let url = Bundle.main.url(forResource: "Turkcell_Assignment", withExtension: "omo", subdirectory: "Turkcell_Assignment.momd") else {
            fatalError("model version not found")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: url) else {
            fatalError("cannot open model at \(url)")
        }
        return managedObjectModel
    }()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Turkcell_Assignment", managedObjectModel: managedObject)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return persistentContainer.viewContext
    }()
    
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return persistentContainer.newBackgroundContext()
    }()
}

// MARK: - Add
extension CoreDataManager {
    func saveProduct(data: [DetailResponseModel]) {
        
        _ = data.map{self.createEntityFrom(product: $0)}
        saveData()
    }
    
    private func createEntityFrom(product: DetailResponseModel) -> ProductList?{
        
        let productList = ProductList(context: self.context)
        productList.name = product.name
        productList.price = Int32(product.price)
        productList.product_id = product.product_id
        productList.image = product.image
        return productList
    }
    
    func saveDetail(data: DetailResponseModel) {
        
        let detail = Detail(context: self.context)
        detail.name = data.name
        detail.image = data.image
        detail.price = Int32(data.price)
        detail.product_id = data.product_id
        detail.product_desc = data.description ?? ""
        saveData()
    }
}
// MARK: - Fetch
extension CoreDataManager {
    public typealias TotalCompletion = ((_ count: Int) -> ())
    public typealias FetchCompletion<M> = ((_ fetched: [M]) -> ())
    
    public func total<M: NSManagedObject>(_ type: M.Type, _ completion: TotalCompletion? = nil) -> Int {
        
        var count = 0
        let entityName = String(describing: type)
        let request = NSFetchRequest<M>(entityName: entityName)
        
        if let completion = completion {
            self.context.perform {
                let _ = self.fetchTotal(request, completion)
            }
        }
        else {
            count = fetchTotal(request)
        }
        return count
    }
    
    private func fetchTotal<M: NSManagedObject>(_ request: NSFetchRequest<M>,
                                                _ completion: TotalCompletion? = nil) -> Int {
        var count = 0
        do {
            count = try context.count(for: request)
            completion?(count)
        }
        catch {
            print("Error executing total: \(error)")
            completion?(0)
        }
        return count
    }
    
    public func fetch<M: NSManagedObject>(_ type: M.Type,
                                          predicate: NSPredicate?=nil,
                                          sort: NSSortDescriptor?=nil,
                                          _ completion: FetchCompletion<M>?=nil) -> [M]? {
        var fetched: [M]?
        let entityName = String(describing: type)
        let request = NSFetchRequest<M>(entityName: entityName)
        
        request.predicate = predicate
        request.sortDescriptors = [sort] as? [NSSortDescriptor]
        
        if let completion = completion {
            self.context.perform {
                let _ = self.fetchObjects(request, completion)
            }
        }
        else {
            fetched = fetchObjects(request)
        }
        return fetched
    }
    
    private func fetchObjects<M: NSManagedObject>(_ request: NSFetchRequest<M>,
                                                  _ completion: FetchCompletion<M>?=nil) -> [M] {
        var fetched: [M] = [M]()
        
        do {
            fetched = try context.fetch(request)
            completion?(fetched)
        }
        catch {
            print("Error executing fetch: \(error)")
            completion?(fetched)
        }
        return fetched
    }
}

// MARK: - Save
extension CoreDataManager {
    
    public func saveData() {
        context.perform {
            if self.context.hasChanges {
                do {
                    try self.context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
    }
}
