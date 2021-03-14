//
//  ShowPostsController.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import UIKit


/// Show list of Post in a tableView, with the ability to add
/// to cart on selecting post
///
class ShowPostsController: UIViewController {
    
    var postService: PostService!
    var posts: [ShowPost] = []
    var page: Int = 0
    var fetchPage: Int?

    // view Attrs
    @IBOutlet weak var tableView: UITableView!
    var refreshControll: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postService = .init()
        
        tableView.registerWithNib(ShowPostCell.self, for: "cell")
        tableView.tableFooterView = .init(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        refreshControll = .init()
        refreshControll.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        tableView.addSubview(refreshControll)
        
    }
    
 
    // MARK: - Fetch data
    
    func getAllPosts() {
        
        do{
            self.posts += try postService.getAllPosts(page: page)
            
        }catch{
            print(error)
            alertAttention(error: error)
        }
    }
    
    func reloadPosts() {
        
        getAllPosts()
        tableView.reloadData()
    }
    
    /// Fetch posts from API and show them in tableView
    ///
    func fetchPosts() {
        
        refreshControll.beginRefreshing()
        postService.fetchAllPosts(page: self.fetchPage, self.didFetchPosts)
    }
    
    /// Called on finish loading posts from API
    func didFetchPosts(error: Error?) {
        
        // append loaded data
        self.fetchPage = (self.fetchPage ?? 0) + 1
        
        // need to do this in main cause we are accessing the view
        DispatchQueue.main.async { [weak self] in
            
            guard let _self = self else { return }
            if let _error = error {
                print(_error)
                _self.alertAttention(error: _error)
            }
            _self.refreshControll.endRefreshing()
            _self.reloadPosts()
        }
    }
    
    /// Pull to refreash action
    @objc func refreshPosts() {
        
        posts = []
        fetchPage = nil
        fetchPosts()
    }
    
}


extension ShowPostsController: UITableViewDelegate, UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShowPostCell
        
        let item = posts[indexPath.row]
        cell.showPost(item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let item = posts[indexPath.row]
        
        let controller = ShowPostDetailController(item)
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
     
    /// Load more like infinite scroll
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom
        if maximumOffset < currentOffset {
            fetchPosts()
            print(maximumOffset - currentOffset)
            
        }
    }
    
}

