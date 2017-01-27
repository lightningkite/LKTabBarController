//
//  Xibs.swift
//  Taxbot
//
//  Created by Jim Schultz on 9/30/15.
//  Copyright © 2015 Lightning Kite. All rights reserved.
//

import UIKit

extension UIView {
	class func view(_ nib: UINib?) -> AnyObject? {
		guard let nib = nib?.instantiate(withOwner: nil, options: nil).first, (nib as AnyObject).isKind(of: self) else {
			return nil
		}
		
		return nib as AnyObject?
	}
	
	class func nib() -> UINib? {
		let bundle = Bundle(for: self)
		guard let name = nibName() else { return nil }
		return UINib(nibName: name, bundle: bundle)
	}
	
	class func viewIdentifier() -> String? {
		return className()
	}
	
	class func nibName() -> String? {
		return viewIdentifier()
	}
	
	class func className() -> String? {
		let name = NSStringFromClass(self)
		return name.components(separatedBy: ".").last
	}
}

