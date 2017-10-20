//
//  LoginTextField.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/20/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import Foundation
import UIKit


class LoginTextField : UIView {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var txtField: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpView()
    }
    
    private func setUpView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        imageView.tintColor = Colors.grayLightColor
        
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
}
