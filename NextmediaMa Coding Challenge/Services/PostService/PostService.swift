//
//  PostService.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import Foundation

/// Fetch Posts from API to show in a list.
/// Add, delete post from/ to Cart
class PostService {
     
    let categoryService: CategoryService
    
    init() {
        
        categoryService = .init()
    }
    
    // MARK: - Fetch data from API
    
    /// Fetch Posts from API
    /// - parameter completion: run when response comes back with decoded result or error if it fails
    func fetchAllPosts(page: Int?, _ completion: @escaping (Error?) -> ()) {
        
        var request = NetworkService.shared
            .createRequest(.get, .posts)
            
        if let _page = page {
            request = request.setupQuery((key: "page", val: _page.description))
        }
        
        request.makeCall { result in
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
        let posts = try decoder.decode([DecodablePost].self, from: json)
    
        try self.savePosts(decoded: posts)
    }
    
    /// Persiste Fetched posts in local storage of coreData
    private func savePosts(decoded posts: [DecodablePost]) throws {

        print(" posts decoded", posts.compactMap({ $0.categories }))
        try PostDAO.perform { dao in
            for post in posts {
                try dao.createOrUpdateBy(
                    id: Int64(post.id),
                    title: post.title.rendered,
                    content: post.content.rendered,
                    date: post.date?.toDate(),
                    categoryId: Int64(post.categories.first ?? 0)
                )
            }
        }
    }

    
    /// Fetch all existing posts in local
    ///
    /// We should add pagination here to avoid lagging if cart was too big
    ///
    func getAllPosts(page: Int) throws -> [ShowPost] {
        
        let limit = 10
        let offset = limit * page
        
        var items: [PostDAO.DataPost] = []
        try PostDAO.perform { dao in
            items = try dao.getAll(limit: limit, offset: offset)
        }
         
        let allCategories = try categoryService.getAllCategories()
        
        return items.map({ item in
            var post = ShowPost(item)
            post.category = allCategories.first(where: { $0.id == item.categoryId})
            return post
        })
    }
    
    func getAllPostsBy(categoryId: Int64, page: Int) throws -> [ShowPost] {
        
        let limit = 10
        let offset = limit * page
        
        var items: [PostDAO.DataPost] = []
        try PostDAO.perform { dao in
            items = try dao.getAllBy(categoryId: categoryId, limit: limit, offset: offset)
        }
        
        let category = try categoryService.findCategoryBy(categoryId)
        
        print(category)
        print(items.count)
        return items.map({ item in
            var post = ShowPost(item)
            post.category = category
            return post
        })
    }
    
}
