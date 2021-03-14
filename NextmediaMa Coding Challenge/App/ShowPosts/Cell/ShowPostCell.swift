//
//  ShowPostCell.swift
//  NextmediaMaCodingChallenge
//
//  Created by Brahim ELMSSILHA on 3/14/21.
//

import UIKit

class ShowPostCell: UITableViewCell {
    
     
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postCategory: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showPost(_ item: ShowPost) {
        
        self.postTitle.text = item.title
        self.postDate.text = item.date?.toString()
        self.postCategory.text = item.category?.title
    }
    
}
