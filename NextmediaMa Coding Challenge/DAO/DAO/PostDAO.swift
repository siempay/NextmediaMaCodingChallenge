//
//  PostDAO.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import Foundation
import CoreData


/// This represente the Data Access layer of the entity `Post`
///
/// We make sure that the interaction with contexts is thread safe.
///
/// We make sure that DAO is decoupled from Service and View layers.
/// So if we want to separate each of theme in a pod of framework or even
/// replace theme, it would be easy.
///
final class PostDAO: IEntityDAO {
    
    struct DataPost {
        
        let id: Int64
        let title: String?
        let content: String?
        let date: Date?
        let categoryId: Int64?
 
        init(_ item: M) {
            self.id = item.id
            self.title = item.title
            self.content = item.content
            self.date = item.date
            self.categoryId = item.category?.id
        }
    }
    
    typealias M = Post
    let context: NSManagedObjectContext
    
    /// This class can be accessed only throu the `.preform` action
    /// - parameter context: depending on where we are calling this,
    /// the context can be viewContext or background
    internal init(context: NSManagedObjectContext) {
        
        self.context = context
    }
     
    /// Fetch all existing items
    private func fetchAll(predicate: NSPredicate?, limit: Int, offset: Int) throws -> [DataPost] {
        
        let request: NSFetchRequest<M> = makeRequest(predicates: [])
        request.fetchLimit = limit
        request.fetchOffset = offset
        request.predicate = predicate
        let result = try context.fetch(request)
        return result.map({ DataPost($0)})
    }
    
    func getAll(limit: Int, offset: Int) throws -> [DataPost] {
        
        return try fetchAll(predicate: nil, limit: limit, offset: offset)
    }
    
    /// Fetch all existing items
    func getAllBy(categoryId: Int64, limit: Int, offset: Int) throws -> [DataPost] {
        
        let predicate = NSPredicate(format: "%K == %d", "category.id", categoryId)
        return try fetchAll(predicate: predicate, limit: limit, offset: offset)
    }
    
    /// Create new Post and insert it
    @discardableResult
    func createOrUpdateBy(
        id: Int64,
        title: String?,
        content: String?,
        date: Date?,
        categoryId: Int64?
    ) throws -> DataPost {
        
        var item: M? = try findBy(id: id, on: context)
        
        if item == nil {
            item = Post.init(context: context)
        }
        
        item?.title = title
        item?.content = content
        item?.date = date
        item?.category = nil
        if let _categoryId = categoryId {
            item?.category = try findBy(id: _categoryId, on: context)
        }
        try context.save()
        
        return .init(item!)
    }
}


