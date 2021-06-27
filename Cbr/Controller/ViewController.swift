//
//  ViewController.swift
//  Cbr
//
//  Created by Евгений Фирман on 27.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    struct Cell{
        
        static let tableCell = "TableViewCell"
    }

    var tableView = UITableView()
    
    let xmlparser = XMLParserClass()
    
    var currency: [Currency] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        xmlparser.delegate = self
        
        self.xmlparser.URLSetter()
        
        self.configureTableView()
     
         
    }
 
    func configureTableView(){
        
        view.addSubview(tableView)
        
        setTableViewDelegates()
        
        tableView.rowHeight = 50
    }
    
    func setTableViewDelegates(){
        
        tableView.delegate = self
        
        tableView.dataSource = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: Cell.tableCell)
        
        tableView.pin(to: view)
    }
}



// MARK: TableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.tableCell) as! TableViewCell
        
        let currency = currency[indexPath.row]
        
        cell.set(currency: currency)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}
extension ViewController: CurrencyDelegate {
    func didUpdateCurrency(currency: [Currency]) {
        DispatchQueue.main.async {
            self.currency = currency
            self.tableView.reloadData()
        }
    }
}
