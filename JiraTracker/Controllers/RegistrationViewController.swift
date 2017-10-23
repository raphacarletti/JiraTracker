//
//  LoginViewController.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/20/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var userTextField: LoginTextField!
    @IBOutlet var passwordTextField: LoginTextField!
    @IBOutlet var progressButton: CustomProgressButton!
    
    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userTextField.imageView.image = UIImage(named: "ic_email")
        self.userTextField.textField.textColor = UIColor.white

        self.passwordTextField.imageView.image = UIImage(named: "ic_lock")
        self.passwordTextField.textField.textColor = UIColor.white
        self.passwordTextField.textField.isSecureTextEntry = true
        
        self.progressButton.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - CustomProgressButton Delegate
extension RegistrationViewController : CustomProgressButtonDelegate {
    func didTapCTAButton(_ sender: Any) {
        //FIXME: Add Login Method
        self.progressButton.setProgressBar(progress: 1.0, progressBarColor: UIColor.red, buttonTitleColor: UIColor.black, animated: true)
    }
}
