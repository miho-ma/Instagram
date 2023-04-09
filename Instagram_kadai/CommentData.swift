//
//  CommentData.swift
//  Instagram_kadai
//
//  Created by user on 2023/04/06.
//

import UIKit
import Firebase

class CommentData: NSObject {
    var id: String
    var name: String?
    var comment: String?
    var date: Date?
    var post: String?

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let commentDic = document.data()

        self.name = commentDic["name"] as? String

        self.comment = commentDic["comment"] as? String

        let timestamp = commentDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        self.post = commentDic["post"] as? String

    }
    

}
