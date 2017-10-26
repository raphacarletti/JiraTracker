//
//  LoginViewController.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/20/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var userTextField: LoginTextField!
    @IBOutlet var passwordTextField: LoginTextField!
    @IBOutlet var progressButton: CustomProgressButton!
    @IBOutlet var becomeAJiraTrackerButton: UIButton!

    //MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        self.userTextField.imageView.image = UIImage(named: "ic_email")
        self.userTextField.textField.textColor = UIColor.black
        self.userTextField.textField.placeholder = "E-mail"
        self.userTextField.textField.delegate = self

        self.passwordTextField.imageView.image = UIImage(named: "ic_lock")
        self.passwordTextField.textField.textColor = UIColor.black
        self.passwordTextField.textField.isSecureTextEntry = true
        self.passwordTextField.textField.placeholder = "Password"
        self.passwordTextField.textField.delegate = self
        
        self.progressButton.delegate = self
        
        self.navigationController?.navigationBar.tintColor = Colors.jiraBlue
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        
        if Auth.auth().currentUser != nil {
            goToJirasScreen(animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources @objc that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.progressButton.setInitialState(animated: false)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    //MARK: - IBAction
    @IBAction func didTapBecomeAJiraTrackerButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Registration", bundle: nil)
        let registration = storyboard.instantiateViewController(withIdentifier: "Registration")
        self.navigationController?.pushViewController(registration, animated: true)
    }
    
    //MARK: - Navigation
    func goToJirasScreen(animated: Bool) {
        let storyboard = UIStoryboard(name: "Application", bundle: nil)
        let jiraScreen = storyboard.instantiateViewController(withIdentifier: "jirasScreen")
        self.navigationController?.pushViewController(jiraScreen, animated: animated)
    }
}

//MARK: - CustomProgressButton Delegate
extension LoginViewController : CustomProgressButtonDelegate {
    func didTapCTAButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isEnabled = false
        if let user = userTextField.textField.text {
            if let password = passwordTextField.textField.text {
                Auth.auth().signIn(withEmail: user, password: password, completion: { (user, error) in
                    if error != nil {
                        self.progressButton.setProgressBar(progress: 1.0, buttonTitle: "Error", progressBarColor: Colors.progressRed, buttonTitleColor: UIColor.white, animated: true, completion: nil)
                        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                            self.progressButton.setInitialState(animated: true)
                        })
                    } else {
                        self.progressButton.setProgressBar(progress: 1.0, buttonTitle: "Sucess", progressBarColor: Colors.greenColor, buttonTitleColor: UIColor.white, animated: true, completion: nil)
                        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                            self.goToJirasScreen(animated: true)
                        })
                    }
                })
            }
        }
    }
}

//MARK: - TextFieldDelegate
extension LoginViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
