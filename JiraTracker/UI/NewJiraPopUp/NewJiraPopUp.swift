//
//  NewJiraPopUp.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/24/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//

import Foundation
import UIKit

protocol NewJiraPopUpDelegate {
    func didTapSaveButton()
    func didTapToDismiss()
}

class NewJiraPopUp : UIView {
    
    var delegate: NewJiraPopUpDelegate?
    @IBOutlet var popUp: UIView!
    @IBOutlet var backView: UIView!
    
    //MARK: - Functions
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
        popUp.layer.cornerRadius = 5
        backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapToDismiss(_:))))
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        self.delegate?.didTapSaveButton()
    }
    
    @objc func didTapToDismiss(_ sender: Any) {
        self.delegate?.didTapToDismiss()
    }
    
}
