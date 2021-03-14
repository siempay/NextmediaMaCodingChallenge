//
//  ShowPostDetailController.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import UIKit

class ShowPostDetailController: UIViewController {

    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postContent: UITextView!
    @IBOutlet weak var postCategory: UILabel!
    
    var selectedPost: ShowPost!

    convenience init(_ item: ShowPost) {
        self.init(nibName: nil, bundle: nil)
        self.selectedPost = item
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light

        self.postTitle.text = selectedPost.title
        self.postDate.text = selectedPost.date?.toString()
        self.postCategory.text = selectedPost.category?.title
        self.postContent.text = nil
        self.postContent.attributedText = selectedPost.content?.htmlAttributedString()
        self.postContent.textColor = .black
        self.postContent.backgroundColor = .white
        self.postContent.textAlignment = .right
 
    }

    

}
