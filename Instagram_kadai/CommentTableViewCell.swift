//
//  CommentTableViewCell.swift
//  Instagram_kadai
//
//  Created by user on 2023/04/07.
//

import UIKit
import FirebaseStorageUI

class CommentTableViewCell: UITableViewCell {

@IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCommentData(_ commentData: CommentData) {
            // キャプションの表示
        self.commentLabel.text = "\(commentData.name!) : \(commentData.comment!) \n \(commentData.date!)"
        
    }
    
}
