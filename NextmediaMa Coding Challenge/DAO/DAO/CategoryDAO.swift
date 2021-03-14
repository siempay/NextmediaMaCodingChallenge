//
//  CategoryDAO.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import Foundation
import CoreData


final class CategoryDAO: IEntityDAO {
    
    struct DataCategory {
        
        let id: Int64
        let title: String?
 
        init(_ item: M) {
            self.id = item.id
            self.title = item.title
         }
    }
    
    typealias M = Category
    let context: NSManagedObjectContext
    
    /// This class can be accessed only throu the `.preform` action
    /// - parameter context: depending on where we are calling this,
    /// the context can be viewContext or background
    internal init(context: NSManagedObjectContext) {
        
        self.context = context
    }
    
    /// Fetch all existing items
    func getAll() throws -> [DataCategory] {
        
        let request = makeRequest(predicates: [])
        let result = try context.fetch(request)
        return result.map({ DataCategory($0)})
    }
    
    /// Create new Category and insert it
    @discardableResult
    func createBy(
        id: Int64,
        title: String?
    ) throws -> DataCategory {
        
        let item = Category.init(context: context)
        item.id = id
        item.title = title
       
        try context.save()
        
        return .init(item)
    }
    
}


