//
//  TableController.swift
//  
//
//  Created by Andrew Liu on 10/30/17.
//

import Foundation

import UIKit

class TableController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    
    var data:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog(String(data.count))
        table.dataSource = self;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")!
        let text = data[indexPath.row]
        cell.textLabel?.text = text
        return cell
    }
    
    
}
