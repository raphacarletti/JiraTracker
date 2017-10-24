//
//  JirasViewController.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/24/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import UIKit

class JirasViewController: UIViewController {
    
    @IBOutlet var newJiraButton: UIButton!
    
    //MARK: - Variables
    override func viewDidLoad() {
        super.viewDidLoad()
        newJiraButton.imageView?.tintColor = Colors.grayLightColor

        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapNewJira(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Application", bundle: nil)
        let newJira = storyboard.instantiateViewController(withIdentifier: "newJiraScreen")
        newJira.modalPresentationStyle = .overCurrentContext
        self.present(newJira, animated: true, completion: nil)
    }
    
}
