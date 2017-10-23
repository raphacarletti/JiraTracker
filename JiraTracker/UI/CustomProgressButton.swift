//
//  CustomProgressButton.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/23/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//


import Foundation
import UIKit


class CustomProgressButton : UIView {
    @IBOutlet var progressBarConstraints: NSLayoutConstraint!
    @IBOutlet var buttonSignIn: UIButton!
    @IBOutlet var progressBar: UIView!
    
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
        
        addSubview(view)
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
}
