//
//  ListContentVC.swift
//  ButtonBar
//
//  Created by Abraham Done on 3/18/16.
//  Copyright © 2016 LightningKite. All rights reserved.
//

import UIKit

// simple example of a view that can have a stack of views
class ListContentVC: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	var list = ["Yellow", "Orange", "Black", "White"]
	
    override func viewDidLoad() {
        super.viewDidLoad()

		tableView.delegate = self
        tableView.dataSource = self
    }
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if let dest = segue.destinationViewController as? ColorContentVC, index = tableView.indexPathForSelectedRow?.row where list.count > index {
			switch list[index] {
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

extension ListContentVC: UITableViewDelegate {
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        guard let cell = cell as? TableVC else {
            return
        }
        
        cell.label.text = list[indexPath.row]
    }
}

extension ListContentVC: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? TableVC {
            return cell
        }
        
        return UITableViewCell()
    }
}
