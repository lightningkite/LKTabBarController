//
//  LKTabBarController.swift
//
//  Created by Abraham Done on 3/18/16.
//  Copyright © 2016 LightningKite. All rights reserved.
//

import UIKit

import SnapKit

/**
 The button must implement this protocol inorder for LKTabBarController to interact with it and the view which will be attached to the button. The button can be formatted or function in any way as desired as long as it has these properties.
 */
public protocol LKTabBarButtonView {
    /// When the button is selected and its view is made active this will be true, it is false otherwise.
    var selected: Bool { get set }
    /// The index of the button which is set by the tab bar controller.
    var index: Int { get set }
    /// Any interaction with the controller will be done through the delegate.
    var delegate: LKButtonBarIndexDelegate? { get set }
}

/**
 This is how the button can interact with the tab bar to change the index and to set custom actions when the button is tapped.
 */
public protocol LKButtonBarIndexDelegate: class {
    /// The action to take when the button bar was tapped. The index is the button's own index.
    func buttonTapped(_ index: Int)
    /// In case the button needs access to the index of the tab bar controller
    var index: Int { get set }
}

/**
 Simple controller for making a custom tab bar. The buttons are fully customizable, with a simple protocol to implement.
 */
open class LKTabBarController: LKButtonBarIndexDelegate {
    // MARK: - Properties
    /// A button and view that will be paired together
    public typealias TabButtonViewPair = (button: LKTabBarButtonView, viewController: UIViewController)
    
    fileprivate typealias TabButtonNavPair = (button: LKTabBarButtonView, navController: UINavigationController)
    fileprivate var buttonPairs: [TabButtonNavPair]
    
    fileprivate let containerView: UIView
    fileprivate let parentView: UIViewController
    fileprivate let insets: UIEdgeInsets
    
    /**
     The initalizer for the tab bar controller
     
     - parameter buttonPairs: An array of TabButtonViewPairs
     - parameter parentView: The parent view of the the container view
     - parameter containerView: The container that will hold all the tabed views
     - parameter hideNavBar: Hide the internal navigation bar of the view controller, false by default
     - parameter insets: Set the insets of all the tabbed views, UIEdgeInsetsZero by default
     */
    public init(buttonPairs: [TabButtonViewPair], parentView: UIViewController, containerView: UIView, hideNavBar: Bool = true, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        
        self.buttonPairs = []
        self.parentView = parentView
        self.containerView = containerView
        self.insets = insets
        
        for index in 0..<buttonPairs.count {
            let view = buttonPairs[index].viewController
            let navController = UINavigationController(rootViewController: view)
            navController.isNavigationBarHidden = hideNavBar
            
            var button = buttonPairs[index].button
            button.index = index
            button.selected = false
            button.delegate = self
            
            self.buttonPairs.append((button, navController))
        }
        
        buttonTapped(0)
    }
    
    // MARK: - LKButtonBarIndexDelegate implementation
    /**
     Function the button can call to change the tab to itself (or another index if desired).
     - parameter index: The index to change
     */
    open func buttonTapped(_ index: Int) {
        guard index >= 0 && index < buttonPairs.count else {
            return
        }
        
        guard self.index != index else {
            return
        }
        
        self.index = index
        
        for index in 0..<self.buttonPairs.count {
            self.buttonPairs[index].button.selected = false
        }
        
        var pair = self.buttonPairs[index]
        pair.button.selected = true
        self.activeViewController = pair.navController
    }
    
    /// The index of the views. It will only change the view to a view that is within the tab bar's range.
    public var index: Int = 0 {
        didSet {
            if index >= 0 && index < buttonPairs.count {
                buttonTapped(index)
            }
        }
    }
    
    // MARK: - Public facing view control
    /// Clear all the tabs
    open func clearTabs() {
        containerView.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
        
        buttonPairs = []
    }
    
    /// The currently active view controller
    public var navigationController: UINavigationController {
        return self.buttonPairs[index].navController
    }
    
    /// The top view controller of the currently active tab view
    public var topViewController: UIViewController? {
        let nav = self.buttonPairs[index].navController
        return nav.viewControllers.last
    }
    
    /// The number of view controllers are present on the currently active tab view
    public var topControllerStackCount: Int {
        let navControl = self.buttonPairs[index].navController
        return navControl.viewControllers.count
    }
    
    /// Pop the currently active tab view's view controller
    open func popTopViewControllerAnimated(_ animated: Bool = true) {
        let navControl = self.buttonPairs[index].navController
        navControl.popViewController(animated: animated)
    }
    
    /// Pop the currently active tab view to its root controller
    open func popTopViewControllerToRootAnimated(_ animated: Bool = true) {
        let navControl = self.buttonPairs[index].navController
        navControl.popToRootViewController(animated: animated)
    }
    
    // MARK: - Private functions (set active view)
    fileprivate var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(oldValue)
            updateActiveViewController()
        }
    }
    
    fileprivate func removeInactiveViewController(_ inactiveViewController: UIViewController?) {
        if parentView.isViewLoaded {
            if let inActiveVC = inactiveViewController {
                inActiveVC.willMove(toParentViewController: nil)
                inActiveVC.view.removeFromSuperview()
                inActiveVC.removeFromParentViewController()
            }
        }
    }
    
    fileprivate func updateActiveViewController() {
        if parentView.isViewLoaded {
            if let activeVC = activeViewController {
                parentView.addChildViewController(activeVC)
                activeVC.view.frame = containerView.bounds
                containerView.addSubview(activeVC.view)
                activeVC.didMove(toParentViewController: parentView)
                
                activeVC.view.snp_makeConstraints { make in
                    make.edges.equalTo(containerView).inset(self.insets)
                }
            }
        }
    }
}
