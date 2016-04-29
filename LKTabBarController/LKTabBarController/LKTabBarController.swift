//
//  LKTabBarController.swift
//
//  Created by Abraham Done on 3/18/16.
//  Copyright © 2016 LightningKite. All rights reserved.
//

import UIKit

import SnapKit

protocol LKTabBarButtonView {
	var selected: Bool { get set } // set the behavior for the button when it is selected/unselected
	var index: Int { get set } // set by the bar controller
	var delegate: LKButtonBarIndexDelegate? { get set }
}

protocol LKButtonBarIndexDelegate {
	func buttonTapped(index: Int)
	var index: Int { get set }
}

class LKTabBarController: LKButtonBarIndexDelegate {
	
	typealias TabButtonViewPair = (button: LKTabBarButtonView, viewController: UIViewController)
	private typealias TabButtonNavPair = (button: LKTabBarButtonView, navController: UINavigationController)
	
	private var buttonPairs: [TabButtonNavPair]
	
	private let containerView: UIView
	private let parentView: UIViewController
	
	init(buttonPairs: [TabButtonViewPair], parentView: UIViewController, containerView: UIView, hideNavBar: Bool = true) {
		
		self.buttonPairs = []
		self.parentView = parentView
		self.containerView = containerView
		
		for index in 0..<buttonPairs.count {
			let view = buttonPairs[index].viewController
			let navController = UINavigationController(rootViewController: view)
			navController.navigationBarHidden = hideNavBar
			
			var button = buttonPairs[index].button
			button.index = index
			button.selected = false
			button.delegate = self
			
			self.buttonPairs.append((button, navController))
		}
		
		buttonTapped(0)
	}
	
	func buttonTapped(index: Int) {
		if self.index != index {
			self.index = index
		}
		
		for index in 0..<self.buttonPairs.count {
			self.buttonPairs[index].button.selected = false
		}
		
		var pair = self.buttonPairs[index]
		pair.button.selected = true
		self.activeViewController = pair.navController
	}
	
	var index: Int = 0 {
		didSet {
			if index > 0 && index < buttonPairs.count {
				buttonTapped(index)
			}
		}
	}
	
	var navigationController: UINavigationController {
		return self.buttonPairs[index].navController
	}
	
	var topViewController: UIViewController? {
		let nav = self.buttonPairs[index].navController
		return nav.viewControllers.last
	}
	
	var topControllerStackCount: Int {
		let navControl = self.buttonPairs[index].navController
		return navControl.viewControllers.count
	}
	
	func popTopViewControllerAnimated(animated: Bool = true) {
		let navControl = self.buttonPairs[index].navController
		navControl.popViewControllerAnimated(animated)
	}
	
	func popTopViewControllerToRootAnimated(animated: Bool = true) {
		let navControl = self.buttonPairs[index].navController
		navControl.popToRootViewControllerAnimated(animated)
	}
	
	private var activeViewController: UIViewController? {
		didSet {
			removeInactiveViewController(oldValue)
			updateActiveViewController()
		}
	}
	
	private func removeInactiveViewController(inactiveViewController: UIViewController?) {
		if parentView.isViewLoaded() {
			if let inActiveVC = inactiveViewController {
				inActiveVC.willMoveToParentViewController(nil)
				inActiveVC.view.removeFromSuperview()
				inActiveVC.removeFromParentViewController()
			}
		}
	}
	
	private func updateActiveViewController() {
		if parentView.isViewLoaded() {
			if let activeVC = activeViewController {
				parentView.addChildViewController(activeVC)
				activeVC.view.frame = containerView.bounds
				containerView.addSubview(activeVC.view)
				activeVC.didMoveToParentViewController(parentView)
				
				// TODO: Not sure about the -49... i think it is a little dangerous
				activeVC.view.snp_makeConstraints { make in
					make.edges.equalTo(containerView).inset(UIEdgeInsetsMake(0, 0, -49, 0))
				}
			}
		}
	}
}
