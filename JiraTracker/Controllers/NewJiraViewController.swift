//
//  NewJiraViewController.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/24/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import UIKit
import FirebaseDatabase

class NewJiraViewController: UIViewController {
    @IBOutlet var newJiraView: NewJiraPopUp!
    
    var jiras : Jiras!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        newJiraView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewJiraViewController : NewJiraPopUpDelegate {
    func didTapSaveButton() {
        if let jiraName = newJiraView.jiraNameTextField.text {
            if let jiraDescription = newJiraView.jiraDescriptionTextField.text {
                if !self.jiras.jiras.contains(where: { (jira) -> Bool in return jira.name == jiraName }) {
                    let jiraValue = ["description": jiraDescription]
                    Database.database().reference().child("jiras").child(jiraName).setValue(jiraValue)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alert = self.getAlertWithOkAction(title: "This jira is already created", message: "You can't create two jiras with same name!")
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func didTapToDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
