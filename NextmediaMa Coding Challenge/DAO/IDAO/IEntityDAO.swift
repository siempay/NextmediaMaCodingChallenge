//
//  IEntityDAO.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import Foundation
import CoreData

/// DAO protocol that all classes should implement.
///
/// We can added some default functions and there default implementations.
/// like `getAllBy`, `getFirstBy`, `findBy` etc...
///
protocol IEntityDAO {
    
    associatedtype M: NSManagedObject
    
    init(context: NSManagedObjectContext)
    
    func findBy<Model: NSManagedObject>(id: Int64, on context: NSManagedObjectContext) throws -> Model?

}

extension IEntityDAO {
    
    /// Create new fetch request for entity
    /// - returns: fetch request
    func makeRequest<Model: NSManagedObject>(predicates: [NSPredicate]) -> NSFetchRequest<Model> {
        
        let request = NSFetchRequest<Model>.init(entityName: String.init(describing: Model.self))
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        return request
    }
    
    /// Perform actions on Product Data access layer
    ///
    /// This is making interaction with coredata thread safe
    static func perform(_ completion: (Self) throws -> ()) throws {
        
        let context = ContextController.shared.context
        let dao = Self(context: context)
        
        var _error: Error?
        context.performAndWait {
            do{
                try completion(dao)
            }catch{
                _error = error
            }
        }
        if let _error = _error {
            throw _error
        }
    }
    
    /// Find Element By id if existe or return nil
    func findBy<Model: NSManagedObject>(id: Int64, on context: NSManagedObjectContext) throws -> Model? {
        
        let request: NSFetchRequest<Model> = makeRequest(predicates: [.init(format: "%K = %d", "id", id)])
        request.fetchLimit = 1
        return try context.fetch(request).first
    }
}
