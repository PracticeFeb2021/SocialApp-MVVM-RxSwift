//
//  PostListVC.swift
//  PostCell
//
//  Created by Oleksandr Bretsko on 1/2/2021.
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    static let cellReuseId = "PostCell"
    
    
    func configure(with post: Post) {
        
        titleLabel?.text = post.title
        bodyLabel?.text = post.body
    }
}

