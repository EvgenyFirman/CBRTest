//
//  TableViewController.swift
//  Cbr
//
//  Created by Евгений Фирман on 25.06.2021.
//

import UIKit

class TableViewController: UITableViewController {
    
    let xmlparser = XMLParserClass()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        xmlparser.XMLApiCall("https://www.cbr.ru/scripts/XML_daily.asp?date_req=02/03/2002&d=1")
        
     
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
