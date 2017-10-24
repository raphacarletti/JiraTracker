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
        //Settings for layout
        self.emailTextField.imageView.image = UIImage(named: "ic_email")
        self.emailTextField.textField.textColor = UIColor.black
        self.emailTextField.textField.placeholder = "E-mail"
        
        self.passwordTextField.imageView.image = UIImage(named: "ic_lock")
        self.passwordTextField.textField.textColor = UIColor.black
        self.passwordTextField.textField.isSecureTextEntry = true
        self.passwordTextField.textField.placeholder = "Password"
        
        self.confirmPasswordTextField.imageView.image = UIImage(named: "ic_lock")
        self.confirmPasswordTextField.textField.textColor = UIColor.black
        self.confirmPasswordTextField.textField.isSecureTextEntry = true
        self.confirmPasswordTextField.textField.placeholder = "Confirm Password"
        
        self.nameTextField.imageView.image = UIImage(named: "ic_profile")
        self.nameTextField.textField.textColor = UIColor.black
        self.nameTextField.textField.placeholder = "Name"
        
        self.createAccountButton.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.createAccountButton.setInitialState(animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func shouldPaintTextFieldsRed() {
        let color = Colors.progressRed
        self.createAccountButton.setProgressBar(progress: 1.0, buttonTitle: "Sucess", progressBarColor: Colors.progressRed, buttonTitleColor: UIColor.white, animated: true, completion: nil)
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
        shouldPaintTextFieldsWhite()
        if !(emailTextField.textField.text?.isEmpty)!{
            if let email = emailTextField.textField.text {
                if !(passwordTextField.textField.text?.isEmpty)!{
                    if let password = passwordTextField.textField.text {
                        if !(confirmPasswordTextField.textField.text?.isEmpty)!{
                            if let passwordConfirmed = confirmPasswordTextField.textField.text{
                                if !(nameTextField.textField.text?.isEmpty)!{
                                    if let name = nameTextField.textField.text {
                                        if password == passwordConfirmed {
                                            if password.characters.count > 6 {
                                                if email.contains("@") {
                                                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                                                        if error == nil {
                                                            let userValue = ["name": name, "email": email]
                                                            Database.database().reference().child("users").child(user!.uid).setValue(userValue)
                                                            self.createAccountButton.setProgressBar(progress: 1.0, buttonTitle: "Error", progressBarColor: Colors.greenColor, buttonTitleColor: UIColor.white, animated: true, completion: nil)
                                                            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                                                                
                                                            })
                                                        } else {
                                                            let alertController = self.getAlertWithOkAction(title: "Error when creating account", message: "Please, try again, maybe this account already exist")
                                                            self.present(alertController, animated: true, completion: nil)
                                                        }
                                                    })
                                                } else {
                                                    shouldPaintTextFieldsRed()
                                                    let alertController = self.getAlertWithOkAction(title: "Invalid mail", message: "")
                                                    self.present(alertController, animated: true, completion: nil)
                                                }
                                            } else {
                                                shouldPaintTextFieldsRed()
                                                let alertController = self.getAlertWithOkAction(title: "Password invalid", message: "Password need has at least 6 characters")
                                                self.present(alertController, animated: true, completion: nil)
                                            }
                                        } else {
                                            shouldPaintTextFieldsRed()
                                            let alertController = self.getAlertWithOkAction(title: "Passwords don't match", message: "Please, try again")
                                            self.present(alertController, animated: true, completion: nil)
                                        }
                                    }
                                } else {
                                    shouldPaintTextFieldsRed()
                                }
                            }
                        } else {
                            shouldPaintTextFieldsRed()
                        }
                    }
                } else {
                    shouldPaintTextFieldsRed()
                }
            }
        } else {
            shouldPaintTextFieldsRed()
        }
    }
}

