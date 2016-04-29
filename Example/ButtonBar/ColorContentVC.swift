//
//  ColorContentVC.swift
//  ButtonBar
//
//  Created by Abraham Done on 3/18/16.
//  Copyright © 2016 LightningKite. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ColorContentVC: UIViewController {
	
	var color: UIColor = UIColor.blackColor()
		
    override func viewDidLoad() {
        super.viewDidLoad()

		self.view.backgroundColor = color
    }

}
