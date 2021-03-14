//
//  CategoryService.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import Foundation


class CategoryService {
    
    
    init() {
        
    }
    
    // MARK: - Fetch data from API
    
    /// Fetch All categories from API
    /// - parameter completion: run when response comes back with decoded result or error if it fails
    func fetchAllPosts(_ completion: @escaping (Error?) -> ()) {
        
        NetworkService.shared
            .createRequest(.get, .categories)
            .makeCall { result in
                switch result {
                case .success(let any):
                    
                    do{
                        try self.decodeResult(any)
                        completion(nil)
                    }catch{
                        completion(error)
                    }
                    break
                case .Error(let error):
                    completion(error)
                    break
                }
            }
    }
    
    /// Decode Response into appropriate type
    private func decodeResult(_ data: Any) throws {
        
        // decode data
        let decoder = JSONDecoder()
        let json = try JSONSerialization.data(withJSONObject: data)
        let items = try decoder.decode([DecodableCategory].self, from: json)
        
        try self.saveCategories(decoded: items)
    }
    
    /// Persiste Fetched posts in local storage of coreData
    private func saveCategories(decoded items: [DecodableCategory]) throws {
        print("saveCategories", items.compactMap({ $0.id }))

        try CategoryDAO.perform { dao in
            for item in items {
                try dao.createOrUpdateBy(id: Int64(item.id), title: item.name)
            }
        }
    }
    
    
    /// Fetch all existing posts in local
    ///
    /// We should add pagination here to avoid lagging if cart was too big
    ///
    func getAllCategories() throws -> [ShowCategory] {
        
        var items: [CategoryDAO.DataCategory] = []
        try CategoryDAO.perform { dao in
            items = try dao.getAll()
        }
        return items.map({.init($0)})
    }
    
    /// Find Category by id if existe
    func findCategoryBy(_ id: Int64) throws -> ShowCategory? {
        
        var item: CategoryDAO.DataCategory?
        try CategoryDAO.perform { dao in
            item = try dao.findBy(id: id)
        }
        
        guard let _item = item else { return nil }
        return .init(_item)
    }
    
    
}
