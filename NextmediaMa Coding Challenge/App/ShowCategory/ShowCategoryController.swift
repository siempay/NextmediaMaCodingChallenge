//
//  ShowCategoryController.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import UIKit

/// Show categories in collectionView
class ShowCategoryController: UIViewController {

    var categoryService: CategoryService!
    var data: [ShowCategory] = []
    var delegate: ShowCategoryDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryService = .init()
        
        collectionView.registerWithNib(ShowCategoryCell.self, for: "cell")
    
        getAllCategories()
        fetchCategory()
    }
    

    // MARK: - Fetch data
    
    /// get all categories from local storage
    func getAllCategories() {
        
        do{
            self.data = try categoryService.getAllCategories()
            
        }catch{
            print(error)
            alertAttention(error: error)
        }
    }
    
    /// Called after fetching categories from API
    func reloadPosts() {
        getAllCategories()
        collectionView.reloadData()
        
        // notify product controller to refresh
        self.delegate?.didLoadCategories()
    }

    /// Fetch posts from API and show them in tableView
    ///
    func fetchCategory() {
        
        categoryService.fetchAllPosts(didFetchCategories)
    }
    
    /// Called on finish loading posts from API
    func didFetchCategories(error: Error?) {
        
        // need to do this in main cause we are accessing the view
        DispatchQueue.main.async { [weak self] in
            
            guard let _self = self else { return }
            if let _error = error {
                print(_error)
                _self.alertAttention(error: _error)
            }
            _self.reloadPosts()
        }
    }
    

}

extension ShowCategoryController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 1 }
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ShowCategoryCell
        
        if indexPath.section == 0 {
            
            // should add menu icon fontawesome
            cell.label.text = "Menu"
        }else{
            let item = data[indexPath.row]
            cell.label.text = item.title
            cell.label.clipsToBounds = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            self.delegate?.didSelectCategory(category: nil)

        }else{
            
            print(#function, data[indexPath.row])
            self.delegate?.didSelectCategory(category: data[indexPath.row])
        }
    }
    
}
