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
		delegate?.buttonTapped(index)
	}
	
	var delegate: LKButtonBarIndexDelegate?
	var index: Int = 0
	
	var selected: Bool = false {
		didSet {
			if selected {
				button.setTitleColor(self.color, forState: .Normal)
				button.enabled = false
				colorBar.backgroundColor = self.color
			} else {
				button.setTitleColor(UIColor.grayColor(), forState: .Normal)
				button.enabled = true
				colorBar.backgroundColor = UIColor.grayColor()
			}
		}
	}
	
	// user elements
	@IBOutlet weak var button: UIButton!
	@IBOutlet weak var colorBar: UIView!
	
	var color = UIColor.blueColor()
	
	class func create(title: String, color: UIColor) -> ButtonView? {
		guard let view = ButtonView.view(ButtonView.nib()) as? ButtonView else {
			return nil
		}
		
		view.button.setTitle(title, forState: .Normal)
		view.color = color
		
		return view
	}
	
}
