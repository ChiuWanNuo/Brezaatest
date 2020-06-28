//
//  SecondTableViewController.swift
//  Brezaatest
//
//  Created by ChiuWanNuo on 26/06/2020.
//  Copyright © 2020 ChiuWanNuo. All rights reserved.
//

import UIKit

class SecondTableViewController: UITableViewController {
    
    @IBOutlet weak var usericonImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var useremailLabel: UILabel!
    @IBOutlet weak var userphoneLabel: UILabel!
    @IBOutlet weak var userwebsiteLabel: UILabel!
    @IBOutlet weak var useraddressLabel: UILabel!
    @IBOutlet weak var usercompanyLabel: UILabel!
    
    
    var Users : users?
    var postData = [posts]()
    var commentData = [comments]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Users?.username
        getUesrData()
        getPostData()
        getCommentData()
        
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("postData.count", postData.count)
        return postData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        let post = postData[indexPath.row]
        
        
        cell.titleLabel.text = post.title
        cell.numbeerofcommentsLabel.text = "Comment:" + "\(post.commentsCount ?? 0)"
       
        return cell
    }
    
    
    func getUesrData() {
        userNameLabel.text = Users?.name
        useremailLabel.text = Users?.email
        userphoneLabel.text = Users?.phone
        userwebsiteLabel.text = Users?.website
        useraddressLabel.text = "\(Users?.address.street ?? ""), \(Users?.address.suite ?? ""), \(Users?.address.city ?? ""), \(Users?.address.zipcode ?? "")"
        usercompanyLabel.text = "\(Users?.company.name ?? "")"
        
        usericonImageView.image = nil
        let urlStr = "https://api.adorable.io/avatars/285/\(Users?.username ?? "")@adorable.png"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    DispatchQueue.main.async {
                        self.usericonImageView.image = UIImage(data: data)
                    }
                }
                
            }.resume()
        }
    }
    
    func getPostData() {
        let urlStr = "http://jsonplaceholder.typicode.com/posts"
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if(error != nil) {
                print("fail", error?.localizedDescription ?? "")
            } else {
                print("get postdata")
                DispatchQueue.main.async {
                    do {
                        self.postData = try JSONDecoder().decode([posts].self, from: data!)
                        self.postData = self.postData.filter({ (post) -> Bool in
                            return post.userId == 1
                        })
                        self.getCommentData()
                        self.tableView.reloadData()
                    }
                    catch{
                        print(error)
                        
                    }
                }
            }
        }
        task.resume()
    }
    
    
    
    func getCommentData(){
        let urlStr = "http://jsonplaceholder.typicode.com/comments"
        if let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let result = try? JSONDecoder().decode([comments].self, from: data) {
                    
                    DispatchQueue.main.async {
                    
                    for post in self.postData {
                        let comments = result.filter { (comment) -> Bool in
                            return comment.postId == post.id
                        }
                        post.commentsCount = comments.count
                        self.tableView.reloadData()
                    }
                    dump(self.postData)
                    }
                }
            }.resume()
        }
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
