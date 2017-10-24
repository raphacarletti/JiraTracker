//
//  NewJiraViewController.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/24/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import UIKit

class NewJiraViewController: UIViewController {
    @IBOutlet var newJiraView: NewJiraPopUp!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        self.dismiss(animated: true, completion: nil)
    }
    
    func didTapToDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
}
