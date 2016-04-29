//
//  Xibs.swift
//  Taxbot
//
//  Created by Jim Schultz on 9/30/15.
//  Copyright © 2015 Lightning Kite. All rights reserved.
//

import UIKit

extension UIView {
	class func view(nib: UINib?) -> AnyObject? {
		guard let nib = nib?.instantiateWithOwner(nil, options: nil).first where nib.isKindOfClass(self) else {
			return nil
		}
		
		return nib
	}
	
	class func nib() -> UINib? {
		let bundle = NSBundle(forClass: self)
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
		return name.componentsSeparatedByString(".").last
	}
}

