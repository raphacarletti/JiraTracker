//
//  JirasViewController.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/24/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class JirasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - IBOutlets
    @IBOutlet var newJiraButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var welcomeLabel: UILabel!
    
    //MARK: - Variables
    var jiras = Jiras()
    var currentUser : User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newJiraButton.imageView?.tintColor = Colors.grayLightColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let user = Auth.auth().currentUser
        
        tableView.register(JiraTableViewCell.classForCoder(), forCellReuseIdentifier: "jiraCell")
        tableView.register(UINib(nibName: "JiraTableViewCell", bundle: nil), forCellReuseIdentifier: "jiraCell")
        Database.database().reference().child("users").child((user?.uid)!).observeSingleEvent(of: .value) { (snapshot) in
            let data = snapshot.value as! NSDictionary
            let name = data["name"] as! String
            let email = data["email"] as! String
            self.currentUser = User(email: email, uid: snapshot.key, name: name)
            self.welcomeLabel.text = "Hi, \(self.currentUser.name!),  which Jira will we work together? :D"
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
        
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            let uid = snapshot.key
            let data = snapshot.value as! NSDictionary
            if !Users.shared.users.contains(where: { (user) -> Bool in return user.uid == uid }) {
                let name = data["name"] as! String
                let email = data["email"] as! String
                let user = User(email: email, uid: uid, name: name)
                Users.shared.users.append(user)
            }
        }
        
        Database.database().reference().child("jiras").observe(.childAdded) { (snapshot) in
            let name = snapshot.key
            let data = snapshot.value as! NSDictionary
            if !self.jiras.jiras.contains(where: { (jira) -> Bool in return jira.name == name }){
                if let description = data["description"] as? String {
                    let jira = Jira(name: name, description: description)
                    self.jiras.jiras.append(jira)
                }
            }
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapNewJira(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Application", bundle: nil)
        let newJira = storyboard.instantiateViewController(withIdentifier: "newJiraScreen") as! NewJiraViewController
        newJira.jiras = self.jiras
        newJira.modalPresentationStyle = .overCurrentContext
        self.present(newJira, animated: true, completion: nil)
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        //FIXME: Need to catch throw??
        try? Auth.auth().signOut()
        if self.navigationController?.viewControllers.count == 1 {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    //MARK: - Table View Data Source Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.jiras.jiras.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jiraCell", for: indexPath) as! JiraTableViewCell
        cell.jiraName.text = jiras.jiras[indexPath.row].name
        cell.jiraDescription.text = jiras.jiras[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Application", bundle: nil)
        let jiraLog = storyboard.instantiateViewController(withIdentifier: "jiraLogScreen") as! JiraLogViewController
        jiraLog.currentUser = currentUser
        jiraLog.jira = jiras.jiras[indexPath.row]
        self.navigationController?.pushViewController(jiraLog, animated: true)
    }
    
}
