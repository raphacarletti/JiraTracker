//
//  JiraLogViewController.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/25/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import UIKit
import FirebaseDatabase

class JiraLogViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - IBOutlets
    @IBOutlet var clockView: UIView!
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var saveLogButton: UIButton!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    
    //MARK: - Variables
    var timer : Timer!
    var miliseconds : Int = 0
    var date : String!
    var jira : Jira!
    var currentUser : User!
    var dateBackground : Date!
    var dateForeground : Date!
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        clockView.clipsToBounds = true
        clockView.layer.cornerRadius = 125
        clockView.layer.borderWidth = 3
        clockView.layer.borderColor = Colors.progressBlue.cgColor
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let backButton = UIBarButtonItem (image: UIImage(named: "ic_back")!, style: .plain, target: self, action: #selector(goToBack))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.hidesBackButton = true
        
        self.title = jira.name
        
        descriptionLabel.text = jira.description
        
        NotificationCenter.default.addObserver(self, selector: #selector(timerInBackgroud), name: Notification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(timerOffInForeground), name: Notification.Name.UIApplicationWillEnterForeground, object: nil)
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        date = dateFormatter.string(from: Date())
        
        Database.database().reference().child("logs").child(jira.name).observe(.childAdded) { (snapshot) in
            let data = snapshot.value as! NSDictionary
            let key = snapshot.key
            if !self.jira.logs.contains(where: { (log) -> Bool in return log.key == key }) {
                let date = data["dateInitial"] as! String
                let hours = data["hours"] as! Int
                let name = data["uid"] as! String
                let log = Log(dateInitial: date, hours: hours, key: key, name: name)
                self.jira.logs.append(log)
                self.tableView.reloadData()
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func formatTimeToString() -> String {
        let hours = miliseconds/360000
        let minutes = (miliseconds%360000)/6000
        let seconds = ((miliseconds%360000)%6000)/100
        let milisec = ((miliseconds%360000)%6000)%100
        let stringFormat = String(format:"00:%02i:%02i:%02i,%02i", hours, minutes, seconds, milisec)
        return stringFormat
        
    }
    
    func formatTimeToStringInCell(milisec: Int) -> String {
        let hours = milisec/360000
        let minutes = (milisec%360000)/6000
        let stringFormat = String(format:"%02ih %02im", hours, minutes)
        return stringFormat
    }
    
    func getUserNameByUid(uid: String) -> String {
        let index = Users.shared.users.index { (user) -> Bool in
            user.uid == uid
        }
        return Users.shared.users[index!].name
    }
    
    //MARK: - IBActions
    @IBAction func didTapStartStopButton(_ sender: Any) {
        if startStopButton.titleLabel?.text == "Start" {
            startStopButton.setTitle("Stop", for: .normal)
            startStopButton.backgroundColor = Colors.progressRed
            saveLogButton.isHidden = true
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
                    self.miliseconds += 1
                    self.timeLabel.text = self.formatTimeToString()
            })
            RunLoop.main.add(timer, forMode: .commonModes)
            
        } else if startStopButton.titleLabel?.text == "Stop" {
            startStopButton.setTitle("Start", for: .normal)
            startStopButton.backgroundColor = Colors.greenColor
            saveLogButton.isHidden = false
            timer.invalidate()
        }
    }

    @IBAction func didTapSaveLogButton(_ sender: Any) {
        let alertController = getAlertWithYesOrNo(title: "Do you want to save?", message: "") {
            let logValue = ["hours": self.miliseconds, "dateInitial": self.date, "uid": self.currentUser.uid] as [String : Any]
            Database.database().reference().child("logs").child(self.jira.name).childByAutoId().setValue(logValue, withCompletionBlock: { (error, db) in
                if error == nil {
                    self.miliseconds = 0
                    self.timeLabel.text = self.formatTimeToString()
                } else {
                    let alert = self.getAlertWithOkAction(title: "Error saving", message: "")
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Table View Data Source Functions
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jira.logs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as! LogTableViewCell
        cell.resizeWidth(width: tableView.frame.width)
        let log = jira.logs[indexPath.row]
        cell.hoursLabel.text = formatTimeToStringInCell(milisec: log.hours)
        cell.dateLabel.text = log.dateInitial
        cell.nameLabel.text = getUserNameByUid(uid: log.name)
        
        return cell
    }
    
    //MARK: - Navigation Controller Delegate
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    @objc func goToBack() {
        if timeLabel.text != "00:00:00:00,00"{
            let alert = getAlertWithYesOrNo(title: "Are you sure?", message: "Procced will make you lose this track!") {
                self.navigationController?.popViewController(animated: true)
            }
            self.present(alert, animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func timerInBackgroud() {
        dateBackground = Date()
    }
    
    @objc func timerOffInForeground() {
        dateForeground = Date()
        let secondsPassed = dateForeground.timeIntervalSince(dateBackground)
        self.miliseconds += Int(secondsPassed) * 100
    }
}
