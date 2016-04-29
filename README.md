# LKTabBarController

[![Circle CI](https://circleci.com/gh/lightningkite/LKTabBarController.svg?style=svg)](https://circleci.com/gh/lightningkite/LKTabBarController)
[![Version](https://img.shields.io/cocoapods/v/LKTabBarController.svg?style=flat)](http://cocoapods.org/pods/LKTabBarController)
[![License](https://img.shields.io/cocoapods/l/LKTabBarController.svg?style=flat)](http://cocoapods.org/pods/LKTabBarController)
[![Platform](https://img.shields.io/cocoapods/p/LKTabBarController.svg?style=flat)](http://cocoapods.org/pods/LKTabBarController)

A simple tab bar controller for swift

## Features

* Simple protocol implementation to create customized tab buttons
* Tab buttons can be put anywhere
* Quick link buttons and views
* Easily controlled view switching

## Basic Usage

A button must implement the protocol:

```Swift
public protocol LKTabBarButtonView {
    var selected: Bool { get set }
    var index: Int { get set }
    var delegate: LKButtonBarIndexDelegate? { get set }
}
```

Any other customization of the button is up to the designs.

Control of the tab bar from the button will be through the delegate:

```Swift
public protocol LKButtonBarIndexDelegate {
    func buttonTapped(index: Int)
    var index: Int { get set }
}
```

The button needs to be paired with a view controller as this typealias

```Swift
public typealias TabButtonViewPair = (button: LKTabBarButtonView, viewController: UIViewController)
```

An array of `TabButtonViewPair`s will be passed to the `LKTabBarController`'s initializer and that is that.


## Detailed Usage

A button can be created in any view as long as it complies with the  `LKTabBarButtonBarView` protocol. There should also be a button or a gesture recognizer in the view, for some sort of interaction, but the view can have images, text, or what-have-you.

This is an example:

```Swift
class ButtonView: UIView, LKTabBarButtonView {

	// required elements
	
	// The button doesn't do anything to set these, just have them available for the tab bar to set up
	// The delegate is set when it is set as a button/view pair in the LKTabBarController's init function
	var delegate: LKButtonBarIndexDelegate?
	// The index is also set up when it is initialized
	var index: Int = 0
	
	// The actions that can happen when the button's state is changed by the LKTabBarController.
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
	@IBAction func buttonTapped() {
		
		// This is the action that will set the LKTabBarController's index and will change the view
		delegate?.buttonTapped(index)
	}
	...	
}
```

The button will then be paired with an view controller.


```Swift
let buttonViewPairs: [LKTabBarController.TabButtonViewPair] = []
let viewController = SomeViewController()
let button = ButtonView()
	
buttonViewPairs.append((button, viewController))

```

When all the views and buttons are set up the `LKTabBarController` can be initialized.

```Swift
let tabController = LKTabBarController(buttonPairs: buttonViewPairs, parientView: self, containerView: contentView)
```

The `LKTabBarController` will then take care of the view switching inside the container view it is provided.

The actual placement and look of the buttons is completely up to what ever design fits with the project.

## Testing

## Installation

LKTabBarController is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod "LKTabBarController"
```

## Issues, Questions, and Contributing

Have an issue, or want to request a feature? Create an issue in github.

Want to contribute? Add yourself to the authors list, and create a pull request.

## Author

Abraham Done, [abraham@lightningkite.com](mailto:abraham@lightningkite.com)

## License

LKTabBarController is available under the MIT license. see the LICENSE file for more info.