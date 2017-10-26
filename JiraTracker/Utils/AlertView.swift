//
//  AlertView.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/24/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import UIKit
import Foundation

extension UIViewController {
    func getAlertWithOkAction(title: String, message: String) -> UIAlertController{
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        return alertController
    }
    
    func getAlertWithYesOrNo(title: String, message: String, handler: (() -> Void)?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (alertAction) in
            handler?()
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        return alertController
    }
    
    func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}
