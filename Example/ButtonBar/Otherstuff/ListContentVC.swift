//
//  ListContentVC.swift
//  ButtonBar
//
//  Created by Abraham Done on 3/18/16.
//  Copyright © 2016 LightningKite. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

// simple example of a view that can have a stack of views
class ListContentVC: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	var list = Variable<[String]>(["Yellow", "Orange", "Black", "White"])
	let disposeBag = DisposeBag()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		list.asObservable().bindTo(tableView.rx_itemsWithCellIdentifier("Cell", cellType: TableVC.self)) { row, str, cell in
			cell.label.text = str
		}.addDisposableTo(disposeBag)
    }
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let dest = segue.destinationViewController as? ColorContentVC, index = tableView.indexPathForSelectedRow?.row where list.value.count > index {
			switch list.value[index] {
			case "Yellow":
				dest.color = UIColor.yellowColor()
			case "Orange":
				dest.color = UIColor.orangeColor()
			case "Black":
				dest.color = UIColor.blackColor()
			default:
				dest.color = UIColor.whiteColor()
			}
		}
	}
}
