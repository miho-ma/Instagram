//
//  CommentViewController.swift
//  Instagram_kadai
//
//  Created by user on 2023/04/06.
//

import UIKit
import Firebase
import SVProgressHUD

class CommentViewController: UIViewController {
    
    var argString = ""
    var argString2: [PostData] = []

    // コメントデータを格納する配列
    var postArray: [PostData] = []

    var commentArray: [CommentData] = []
    var listener: ListenerRegistration?
    var testData:CommentData?
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func getData() {

        //データがあるコレクションを指定
        let Ref = Firestore.firestore().collection("comments")

        //getDocumentsでデータを取得
        Ref.getDocuments() { (querySnapshot, error) in
            if let error = error {
                print(error)
                return
            }

            self.commentArray = querySnapshot!.documents.map { document in
                let data = CommentData(document: document)

                return data

            }
       }
    }
            
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.commentArray.count
   }

    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func handlePostButton(_ sender: Any) {
        // 画像と投稿データの保存場所を定義する
        let commentRef = Firestore.firestore().collection(Const.CommentPath).document()
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        let name = Auth.auth().currentUser?.displayName
        let commentDic = [
            "name": name!,
            "comment": self.textField.text!,
            "date": FieldValue.serverTimestamp(),
            "post": argString
        ] as [String : Any]
        commentRef.setData(commentDic)
        
        // 配列からタップされたインデックスのデータを取り出す
        var updateValue: FieldValue
        
        updateValue = FieldValue.arrayUnion(["\(name!) : \(self.textField.text!)" ])
        
        // commentsに更新データを書き込む
        let postRef = Firestore.firestore().collection(Const.PostPath).document(argString)
        postRef.updateData(["comments": updateValue])
        
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        // 投稿処理が完了したので先頭画面に戻る
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
