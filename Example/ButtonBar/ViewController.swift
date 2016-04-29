//
//  ViewController.swift
//  ButtonBar
//
//  Created by Abraham Done on 3/18/16.
//  Copyright © 2016 LightningKite. All rights reserved.
//

import UIKit

import LKTabBarController

class ViewController: UIViewController {

	@IBOutlet weak var button1: ButtonView!
	@IBOutlet weak var button2: ButtonView!
	@IBOutlet weak var button3: ButtonView!
	@IBOutlet weak var contentView: UIView!
	
	var tabBarControll: LKTabBarController?
	
	@IBAction func backTapped() {
		tabBarControll?.popTopViewControllerAnimated()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		var buttons: [LKTabBarController.TabButtonViewPair] = []
		
		if let button1view = ButtonView.create("purple", color: UIColor.greenColor()) {
			button1.addSubview(button1view)
			
			let view = UIStoryboard(name: "ColorContent", bundle: nil).instantiateInitialViewController() as! ColorContentVC
			view.color = UIColor(colorLiteralRed: 0.5, green: 0.2, blue: 0.8, alpha: 1.0)
			
			buttons.append((button1view, view))
		}
		
		if let button2view = ButtonView.create("list", color: UIColor.greenColor()) {
			button2.addSubview(button2view)
			
			let view = UIStoryboard(name: "ListContent", bundle: nil).instantiateInitialViewController()

			buttons.append((button2view, view!))
		}
		
		if let button3view = ButtonView.create("blue", color: UIColor.greenColor()) {
			button3.addSubview(button3view)
			
			let view = UIStoryboard(name: "ColorContent", bundle: nil).instantiateInitialViewController() as! ColorContentVC
			view.color = UIColor(colorLiteralRed: 0.0, green: 0.3, blue: 0.7, alpha: 1.0)
			
			buttons.append((button3view, view))
		}
		
		self.tabBarControll = LKTabBarController(buttonPairs: buttons, parentView: self, containerView: contentView)
		tabBarControll?.index = 2
	}
}
