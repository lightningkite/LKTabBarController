//
//  ButtonBarTests.swift
//  ButtonBarTests
//
//  Created by Abraham Done on 3/18/16.
//  Copyright © 2016 LightningKite. All rights reserved.
//

import XCTest

import LKTabBarController

@testable import ButtonBar

class ButtonBarTests: XCTestCase {
	
	func testButtonView() {
		guard let testButton = ButtonView.create("Testable", color: UIColor.blue) else {
			XCTAssert(false)
			return
		}
		
		XCTAssert(testButton.delegate == nil)
		XCTAssert(testButton.index == 0)
		
		testButton.selected = true
		XCTAssert(testButton.selected)
		XCTAssert(testButton.colorBar.backgroundColor == UIColor.blue)
		XCTAssertFalse(testButton.button.isEnabled)
		
		testButton.selected = false
		XCTAssertFalse(testButton.selected)
		XCTAssert(testButton.colorBar.backgroundColor == UIColor.gray)
		XCTAssert(testButton.button.isEnabled)
	}
	
	func testIndex() {
		guard let button1 = ButtonView.create("Test1", color: UIColor.red), let button2 = ButtonView.create("Test2", color: UIColor.blue) else {
			XCTAssert(false)
			return
		}
		
		let view1 = UIViewController()
		let title1 = "Test1 view"
		view1.title = title1
		let view2 = UIViewController()
		let title2 = "Test2 view"
		view2.title = title2
		let buttonPair: [LKTabBarController.TabButtonViewPair] = [(button1, view1), (button2, view2)]
		
		let parentView = UIViewController()
		let containerView = UIView()
		parentView.view.addSubview(containerView)
		
		let tabBar = LKTabBarController(buttonPairs: buttonPair, parentView: parentView, containerView: containerView)

		XCTAssert(button1.index == 0)
		XCTAssert(button2.index == 1)
		
		tabBar.index = 1
		
		XCTAssertFalse(button1.selected)
		XCTAssert(button2.selected)
		XCTAssert(tabBar.navigationController.title == title2)
		
		tabBar.index = 0
		
		XCTAssert(button1.selected)
		XCTAssertFalse(button2.selected)
		XCTAssert(tabBar.navigationController.title == title1)
		
		tabBar.index = -1
		
		XCTAssert(button1.selected)
		XCTAssertFalse(button2.selected)

		tabBar.index = 2
		
		XCTAssert(button1.selected)
		XCTAssertFalse(button2.selected)
	}
	
	func testButtonTapped() {
		guard let button1 = ButtonView.create("Test1", color: UIColor.red), let button2 = ButtonView.create("Test2", color: UIColor.blue) else {
			XCTAssert(false)
			return
		}
		
		let view1 = UIViewController()
		let view2 = UIViewController()
		let buttonPair: [LKTabBarController.TabButtonViewPair] = [(button1, view1), (button2, view2)]
		
		let parentView = UIViewController()
		let containerView = UIView()
		parentView.view.addSubview(containerView)
		
		let tabBar = LKTabBarController(buttonPairs: buttonPair, parentView: parentView, containerView: containerView)
		
		tabBar.buttonTapped(button1.index)
		
		XCTAssert(button1.selected)
		XCTAssertFalse(button2.selected)
		
		tabBar.buttonTapped(button2.index)
		
		XCTAssertFalse(button1.selected)
		XCTAssert(button2.selected)
		
		tabBar.buttonTapped(-1)
		
		XCTAssertFalse(button1.selected)
		XCTAssert(button2.selected)

		tabBar.buttonTapped(2)
		
		XCTAssertFalse(button1.selected)
		XCTAssert(button2.selected)
	}
}
