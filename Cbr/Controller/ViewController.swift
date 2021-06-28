//  ViewController.swift
//  Cbr
//  Created by Евгений Фирман on 27.06.2021.

import UIKit

class ViewController: UIViewController {
    
    var tableView = UITableView()
    
    let uiView = UIView()
    
    let xmlparser = XMLParserClass()
    
    var currency: [Currency] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Функция скрывающая клавиатуру при тапе на любой элемент интерфейса
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        // Инициализация делегата
        xmlparser.delegate = self
        
        // Парсинг данных из АПИ
        self.xmlparser.URLSetter()
        
        // Установка вью в таблице
        self.configureTableView()
        
        // Установка вью в Хеадере
        self.configureHeaderView()
    }
    
    // UI спрятать клавиатуру по щелчку в любое место на интерфейсе
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - ConfigureHeaderView функция
    
    func configureHeaderView(){
        
        let headerView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 156, height: 100))
        
            headerView.layer.cornerRadius = 10
            headerView.backgroundColor = UIColor(red: 239/255.0, green: 62/255.0, blue: 54/255.0, alpha: 1.0)
        
        let textField: UITextField = UITextField.init(frame: CGRect.init(x: 4, y: 5, width: 180, height: 40))
        
            // Настройки textField
            textField.keyboardType = .decimalPad
            textField.textColor = .black
            textField.layer.borderWidth = 2.0
            textField.backgroundColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 214/255.0, alpha: 1.0)
            textField.layer.cornerRadius = 15
            textField.attributedPlaceholder = NSAttributedString(string: "Цена",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
            textField.textAlignment = NSTextAlignment.center
        
        let buttonHandler: UIButton = UIButton()
            buttonHandler.setTitle("Установить цену", for: .normal)
            buttonHandler.setTitleColor(.blue, for: .normal)
            buttonHandler.backgroundColor = UIColor(red: 46/255.0, green: 40/255.0, blue: 42/255.0, alpha: 1.0)
            buttonHandler.layer.cornerRadius = 15
            buttonHandler.setTitleColor(UIColor.white, for: UIControl.State.normal)
            buttonHandler.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
            
        
        
        headerView.addSubview(textField)
        headerView.addSubview(buttonHandler)
        
        
            // Constraints for textField
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 40).isActive = true
            textField.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
            textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
            textField.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
            // Constraints for button
            buttonHandler.translatesAutoresizingMaskIntoConstraints = false
            buttonHandler.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20).isActive = true
            buttonHandler.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
            buttonHandler.heightAnchor.constraint(equalToConstant: 50).isActive = true
            buttonHandler.widthAnchor.constraint(equalToConstant: 180).isActive = true
     

        //   buttonHandler.addTarget(self, action: #selector(), for: .touchUpInside)
        
        self.tableView.tableHeaderView = headerView
    }
    // MARK: - TableView функции для настройки
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



// MARK: - TableViewDelegate расширения
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    // Метод для выведения количества строк равному количеству элементов
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currency.count
    }
    // Метод для определения содержимого ячейчки
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

// MARK: - CurrencyDelegate расширения для ViewController
extension ViewController: CurrencyDelegate {
    
    func didUpdateCurrency(currency: [Currency]) {
        
        DispatchQueue.main.async {
            
            self.currency = currency
            
            self.tableView.reloadData()
        }
    }
}
