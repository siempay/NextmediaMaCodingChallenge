//
//  IndexController.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import UIKit

class IndexController: UIViewController {

    @IBOutlet weak var categoryView: UIView!
    @IBOutlet weak var postsView: UIView!
    
    var categoriesController: ShowCategoryController!
    var postsController: ShowPostsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        self.postsController = ShowPostsController()
        self.addAsChildViewController(type: postsController, attached: self.postsView)
        
        self.categoriesController = ShowCategoryController()
        self.categoriesController.delegate = self
        self.addAsChildViewController(type: categoriesController, attached: self.categoryView)
        
    }

 
}

/// Delegate of ShowCategoryController
extension IndexController: ShowCategoryDelegate {
    
    func didLoadCategories() {
        
        self.postsController.fetchPosts()
    }
    
    func didSelectCategory(category: ShowCategory?) {
    
        postsController.filterDataBy(category: category)
    }
}
