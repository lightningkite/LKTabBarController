//
//  ButtonView.swift
//  ButtonBar
//
//  Created by Abraham Done on 3/18/16.
//  Copyright © 2016 LightningKite. All rights reserved.
//

import UIKit

import LKTabBarController

class ButtonView: UIView, LKTabBarButtonView {

	// required elements
	@IBAction func buttonTapped() {
		
		// This is the action that will set the LKTabBarController's index and will change the view
		delegate?.buttonTapped(index)
	}
	
	// The button doesn't do anything to set these, just have them available for the tab bar to set up
	// The delegate is set when it is set as a button/view pair in the LKTabBarController's init function
	var delegate: LKButtonBarIndexDelegate?
	// The index is also set up when it is initialized
	var index: Int = 0
	
	// The actions that can happen when the button's state is changed by the LKTabBarController.
	var selected: Bool = false {
		didSet {
			if selected {
				button.setTitleColor(self.color, for: UIControlState())
				button.isEnabled = false
				colorBar.backgroundColor = self.color
			} else {
				button.setTitleColor(UIColor.gray, for: UIControlState())
				button.isEnabled = true
				colorBar.backgroundColor = UIColor.gray
			}
		}
	}
	
	// user elements
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var colorBar: UIView!
	
	var color = UIColor.blue
	
	class func create(_ title: String, color: UIColor) -> ButtonView? {
		guard let view = ButtonView.view(ButtonView.nib()) as? ButtonView else {
			return nil
		}
		
		view.button.setTitle(title, for: UIControlState())
		view.color = color
		
		return view
	}
	
}
