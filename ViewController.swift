//
//  ViewController.swift
//  Firebase Database
//
//  Created by Moyang Erica Wang on 2016-12-29.
//  Copyright © 2016 Moyang Erica Wang. All rights reserved.
//

import UIKit
import Firebase

struct postStruct {
    var title: String
    var message: String
}

class ViewController: UITableViewController {
    
    var posts = [postStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseRef = FIRDatabase.database().reference()
        databaseRef.child("post").queryOrderedByKey().observe(.childAdded, with: {
            snapshot in
            
            let snapshotValue = snapshot.value as? NSDictionary
            let title = snapshotValue?["title"] as? String
            let message = snapshotValue?["message"] as? String
            
            self.posts.insert(postStruct(title: title!, message: message!), at: 0)
            self.tableView.reloadData()
            
        })
        
        post()
        
    }
    
    func post (){
        
        let title = "Title"
        let message = "Message"
        
        let post: [String: String] = ["title":title,
                                      "message":message]
        
        let databaseRef = FIRDatabase.database().reference()
        
        databaseRef.child("post").childByAutoId().setValue(post)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        let label1 = cell?.viewWithTag(1) as! UILabel
        label1.text = posts[indexPath.row].title
        
        let label2 = cell?.viewWithTag(2) as! UILabel
        label2.text = posts[indexPath.row].message
        
        return cell!
    }


}

