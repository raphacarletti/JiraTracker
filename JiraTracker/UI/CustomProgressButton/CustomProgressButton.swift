//
//  CustomProgressButton.swift
//  JiraTracker
//
//  Created by Raphael Carletti on 10/23/17.
//  Copyright © 2017 Raphael Carletti. All rights reserved.
//


import Foundation
import UIKit

protocol CustomProgressButtonDelegate {
    func didTapCTAButton(_ sender: Any)
}

class CustomProgressButton : UIView {
    //MARK: - IBOutlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var progressBarWidthConstraint: NSLayoutConstraint!
    @IBOutlet private var CTAButton: UIButton!
    @IBOutlet private var progressBar: UIView!
    
    //MARK: - Variables
    var delegate: CustomProgressButtonDelegate?
    
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
        
        self.progressBar.backgroundColor = UIColor.gray
    }
    
    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    //MARK: - IBActions
    @IBAction func didTapCTAButton(_ sender: Any) {
        self.delegate?.didTapCTAButton(sender)
    }
    
    //MARK: - Progress
    func setProgressBar(progress: Float, animated: Bool) {
        self.setProgressBar(progress: progress, progressBarColor: self.progressBar.backgroundColor, buttonTitleColor: self.CTAButton.titleColor(for: .normal), animated: animated)
    }
    
    func setProgressBar(progress: Float, progressBarColor: UIColor?, buttonTitleColor: UIColor?, animated: Bool) {
        var progress = CGFloat(progress)
        if (progress < 0.0) {
            progress = 0.0
        } else if (progress > 1.0) {
            progress = 1.0
        }
        self.progressBarWidthConstraint.constant = progress * self.contentView.frame.width
        UIView.animate(withDuration: animated ? 1.0 : 0.0) {
            self.setNeedsLayout()
            self.layoutIfNeeded()
            if let progressBarColor = progressBarColor {
                self.progressBar.backgroundColor = progressBarColor
            }
            if let buttonTitleColor = buttonTitleColor {
                self.CTAButton.setTitleColor(buttonTitleColor, for: .normal)
            }
        }
    }
    
    func setProgressBarColor(color: UIColor) {
        self.progressBar.backgroundColor = color
    }
}
