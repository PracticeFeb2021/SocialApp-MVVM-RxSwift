//
//  CommentCell.swift
//  CommentCell
//
//  Created by Oleksandr Bretsko on 1/2/2021.
//

import UIKit

class CommentCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    static let cellReuseId = "CommentCell"
    
    
    func configure(with comment: Comment) {
        
        titleLabel?.text = comment.name
        bodyLabel?.text = comment.body
    }
}

