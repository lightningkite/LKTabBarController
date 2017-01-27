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
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? ColorContentVC, let index = (tableView.indexPathForSelectedRow as NSIndexPath?)?.row, list.count > index {
			switch list[index] {
			case "Yellow":
				dest.color = UIColor.yellow
			case "Orange":
				dest.color = UIColor.orange
			case "Black":
				dest.color = UIColor.black
			default:
				dest.color = UIColor.white
			}
		}
	}
}

extension ListContentVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? TableVC else {
            return
        }
        
        cell.label.text = list[indexPath.row]
    }
}

extension ListContentVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? TableVC {
            return cell
        }
        
        return UITableViewCell()
    }
}
