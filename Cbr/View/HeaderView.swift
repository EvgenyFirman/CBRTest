//
//  HeaderView.swift
//  Cbr
//
//  Created by Евгений Фирман on 29.06.2021.
//

import UIKit

class HeaderView: UIView {
    
    override init(frame: CGRect) {
        <#code#>
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerView: UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 156, height: 100))
    let buttonHandler: UIButton = UIButton()
    let textField: UITextField = UITextField.init(frame: CGRect.init(x: 4, y: 5, width: 180, height: 40))
    let labelField: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    let defaults = ViewController().defaults
    
    
    func configureHeaderView(){
           
        if defaults.float(forKey: "price") == nil {
            
            labelField.isHidden = true
            
        } else {
            
            labelField.isHidden = false
            
        }
        
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
        
        buttonHandler.addTarget(self, action: #selector(ViewController().pressSet), for: .touchUpInside)
        
        // Constraints for lableField
        labelField.translatesAutoresizingMaskIntoConstraints = false
        labelField.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10).isActive = true
        labelField.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        
        self.tableView.tableHeaderView = headerView
    }
    
    
    

}
