//  ViewController.swift
//  Cbr
//  Created by Евгений Фирман on 27.06.2021.

import UIKit

class ViewController: UIViewController {
    
    // UI Elements Initializers
    var tableView = UITableView()
    let uiView = UIView()
    let headerView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 156, height: 100))
    let buttonHandler: UIButton = UIButton()
    let textField: UITextField = UITextField.init(frame: CGRect.init(x: 4, y: 5, width: 180, height: 40))
    let labelField: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    let xmlparser = XMLParserClass()        // Initializers for XMLParserClass
    
    let defaults = UserDefaults.standard
    
    var currency: [Currency] = []           // Currency array
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)      // Disable KeyBoard on tap
        
        xmlparser.delegate = self           // XMLParser Delegate
        
        self.xmlparser.URLSetter()          // API Data Parse
        
        self.configureTableView()           // View set up for TableView
        
        print(defaults.float(forKey: "price"))
        
        self.configureHeaderView()          // View set up for Header
        
        textField.delegate = self           // Text field Delegate
        
        if defaults.float(forKey: "price") == nil {
            
            labelField.isHidden = true
            
        } else {
            
            labelField.isHidden = false
            
        }
        
    }
    
    // UI keyboard on tap on interface
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - ConfigureHeaderView function
    
    func configureHeaderView(){
        
        headerView.layer.cornerRadius = 10
        headerView.backgroundColor = UIColor(red: 239/255.0, green: 62/255.0, blue: 54/255.0, alpha: 1.0)
        
        // Настройки textField
        textField.keyboardType = .decimalPad
        textField.textColor = .black
        textField.layer.borderWidth = 2.0
        textField.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 214/255.0, alpha: 1.0)
        textField.layer.cornerRadius = 15
        textField.attributedPlaceholder = NSAttributedString(string: "Цена",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        // Aligning text in center
        textField.textAlignment = NSTextAlignment.center
        
        // Button Handler
        buttonHandler.setTitle("Установить цену", for: .normal)
        buttonHandler.setTitleColor(.blue, for: .normal)
        buttonHandler.backgroundColor = UIColor(red: 46/255.0, green: 40/255.0, blue: 42/255.0, alpha: 1.0)
        buttonHandler.layer.cornerRadius = 15
        buttonHandler.setTitleColor(UIColor.white, for: UIControl.State.normal)
        buttonHandler.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        
        
        labelField.textAlignment = NSTextAlignment.center
        labelField.text = String("\(defaults.float(forKey: "price")) RUB" )
        labelField.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        labelField.isHidden = true
        labelField.textColor = .black
        
        
        headerView.addSubview(labelField)
        headerView.addSubview(textField)
        headerView.addSubview(buttonHandler)
        
        
        // MARK: - CONSTRAINTS FOR HEADER ELEMENTS
        // Constraints for TextField
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20).isActive = true
        textField.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        // Constraints for button
        buttonHandler.translatesAutoresizingMaskIntoConstraints = false
        buttonHandler.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
        buttonHandler.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        buttonHandler.heightAnchor.constraint(equalToConstant: 50).isActive = true
        buttonHandler.widthAnchor.constraint(equalToConstant: 180).isActive = true
        
        buttonHandler.addTarget(self, action: #selector(pressSet), for: .touchUpInside)
        
        // Constraints for lableField
        labelField.translatesAutoresizingMaskIntoConstraints = false
        labelField.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10).isActive = true
        labelField.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        self.tableView.tableHeaderView = headerView
    }
    
    
    @objc func pressSet(){
        
        textField.endEditing(true)
        
    }
    
    // MARK: - TableView SetUp Functions
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



// MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    // TableView numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.count
    }
    // TableView cellForRow
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



// MARK: - CurrencyDelegate extension for ViewController
extension ViewController: CurrencyDelegate {
    
    func didUpdateCurrency(currency: [Currency]) {
        
        DispatchQueue.main.async {
            
            self.currency = currency
            
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {               // Handling didEndEditing and passing data to storage
        
        if let text = textField.text {
            
            labelField.text = "\(text) RUB"
            
            labelField.isHidden = false
            
           
            let priceValue = Float(text)
            
            defaults.setValue(priceValue, forKey: "price")
        
        }
        
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {     // Handling endEditing method to display placeholder
        
        if textField.text != ""{
            
            return true
            
        } else {
            
            textField.placeholder = "Цена"
            
            return false
        }
    }
}


