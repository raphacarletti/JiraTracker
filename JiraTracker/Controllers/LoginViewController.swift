//
//  LoginViewController.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/20/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var userTextField: LoginTextField!
    @IBOutlet var passwordTextField: LoginTextField!
    @IBOutlet var progressButton: CustomProgressButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTextField.imageView.image = #imageLiteral(resourceName: "ic_email_36pt")
        passwordTextField.imageView.image = #imageLiteral(resourceName: "ic_lock_36pt")
        userTextField.txtField.textColor = UIColor.white
        passwordTextField.txtField.textColor = UIColor.white
        passwordTextField.txtField.isSecureTextEntry = true
        // Do any additional setup after loading the view.
        
        progressButton.buttonSignIn.addTarget(self, action: #selector(signInTapped(_:)), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func signInTapped(_ sender: Any) {
        //self.progressButton.progressBarConstraints.constant = -(self.progressButton.buttonSignIn.frame.width * 0.3)
        self.progressButton.progressBarConstraints.constant = 0
        UIView.animate(withDuration: 1) {
            self.progressButton.setNeedsLayout()
            self.progressButton.layoutIfNeeded()
//            self.progressButton.progressBar.backgroundColor = Colors.greenColor
            self.progressButton.progressBar.backgroundColor = UIColor.red
            self.progressButton.buttonSignIn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    
}
