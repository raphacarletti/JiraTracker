//
//  RegistrationViewController.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/24/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationViewController : UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var nameTextField: LoginTextField!
    @IBOutlet var emailTextField: LoginTextField!
    @IBOutlet var passwordTextField: LoginTextField!
    @IBOutlet var confirmPasswordTextField: LoginTextField!
    @IBOutlet var createAccountButton: CustomProgressButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        //Settings for layout
        self.emailTextField.imageView.image = UIImage(named: "ic_email")
        self.emailTextField.textField.textColor = UIColor.black
        self.emailTextField.textField.placeholder = "E-mail"
        self.emailTextField.textField.delegate = self
        
        self.passwordTextField.imageView.image = UIImage(named: "ic_lock")
        self.passwordTextField.textField.textColor = UIColor.black
        self.passwordTextField.textField.isSecureTextEntry = true
        self.passwordTextField.textField.placeholder = "Password"
        self.passwordTextField.textField.delegate = self
        
        self.confirmPasswordTextField.imageView.image = UIImage(named: "ic_lock")
        self.confirmPasswordTextField.textField.textColor = UIColor.black
        self.confirmPasswordTextField.textField.isSecureTextEntry = true
        self.confirmPasswordTextField.textField.placeholder = "Confirm Password"
        self.confirmPasswordTextField.textField.delegate = self
        
        self.nameTextField.imageView.image = UIImage(named: "ic_profile")
        self.nameTextField.textField.textColor = UIColor.black
        self.nameTextField.textField.placeholder = "Name"
        self.nameTextField.textField.delegate = self
        
        self.createAccountButton.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.createAccountButton.setInitialState(animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        nameTextField.textField.text = ""
        emailTextField.textField.text = ""
        passwordTextField.textField.text = ""
        confirmPasswordTextField.textField.text = ""
    }
    
    func goToJirasScreen(animated: Bool) {
        let storyboard = UIStoryboard(name: "Application", bundle: nil)
        let jiraScreen = storyboard.instantiateViewController(withIdentifier: "jirasScreen")
        self.navigationController?.pushViewController(jiraScreen, animated: animated)
    }
    
    func shouldPaintTextFieldsRed() {
        self.createAccountButton.enableCTA(enable: true)
        let color = Colors.progressRed
        self.createAccountButton.setProgressBar(progress: 1.0, buttonTitle: "Error", progressBarColor: Colors.progressRed, buttonTitleColor: UIColor.white, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
            self.createAccountButton.setInitialState(animated: true)
        })
        if (nameTextField.textField.text?.isEmpty)! {
            self.nameTextField.paintBarAndImage(color: color)
        }
        if (emailTextField.textField.text?.isEmpty)! || !emailTextField.textField.text!.contains("@") {
            self.emailTextField.paintBarAndImage(color: color)
        }
        if (passwordTextField.textField.text?.isEmpty)! || passwordTextField.textField.text!.characters.count <= 6 {
            self.passwordTextField.paintBarAndImage(color: color)
        }
        if (confirmPasswordTextField.textField.text?.isEmpty)! || confirmPasswordTextField.textField.text!.characters.count <= 6{
            self.confirmPasswordTextField.paintBarAndImage(color: color)
        }
    }
    
    func shouldPaintTextFieldsWhite() {
        let color = Colors.grayLightColor
        self.nameTextField.paintBarAndImage(color: color)
        self.emailTextField.paintBarAndImage(color: color)
        self.passwordTextField.paintBarAndImage(color: color)
        self.confirmPasswordTextField.paintBarAndImage(color: color)
    }
}

//MARK: - CustomProgressButton Delegate
extension RegistrationViewController : CustomProgressButtonDelegate {
    func didTapCTAButton(_ sender: Any) {
        let button = sender as! UIButton
        button.isEnabled = false
        shouldPaintTextFieldsWhite()
        if let name = nameTextField.textField.text,
            let email = emailTextField.textField.text,
            let password = passwordTextField.textField.text,
            let confirmPassword = confirmPasswordTextField.textField.text {
            if name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                shouldPaintTextFieldsRed()
            } else if !email.contains("@") {
                shouldPaintTextFieldsRed()
                let alertController = self.getAlertWithOkAction(title: "Invalid mail", message: "")
                self.present(alertController, animated: true, completion: nil)
            } else if password.characters.count < 6 {
                shouldPaintTextFieldsRed()
                let alertController = self.getAlertWithOkAction(title: "Invalid password", message: "Password needs at least 6 characters.")
                self.present(alertController, animated: true, completion: nil)
            } else if password != confirmPassword {
                shouldPaintTextFieldsRed()
                let alertController = self.getAlertWithOkAction(title: "Passwords don't match", message: "")
                self.present(alertController, animated: true, completion: nil)
            } else {
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    if let error = error {
                        button.isEnabled = true
                        let alertController = self.getAlertWithOkAction(title: "Error creating account", message: "\(error.localizedDescription)")
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        let userValue = ["name": name, "email": email]
                        Database.database().reference().child("users").child(user!.uid).setValue(userValue)
                        self.createAccountButton.setProgressBar(progress: 1.0, buttonTitle: "Success", progressBarColor: Colors.greenColor, buttonTitleColor: UIColor.white, animated: true, completion: nil)
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
extension RegistrationViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

