//  TableViewCell.swift
//  Created by Евгений Фирман on 27.06.2021.

import UIKit

class TableViewCell: UITableViewCell {
    
    // Инициализируем поля текста
    var dateTitle = UILabel()
    
    var valueTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Вызываем методы для определения текста и настройки констрейнтов
        addSubview(dateTitle)
        addSubview(valueTitle)
        configureDateTitle()
        configureValueTitle()
        setDateTitleConstraints()
        setValueTitleConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Функция для передачи данных из АПИ
    func set(currency: Currency){
        
        dateTitle.text = "Дата: \(currency.date)"
        valueTitle.text = "Стоимость: \(currency.value) RUB"
    }
    
    // Конфигуратор поля отображения данных о дате из АПИ
    func configureDateTitle(){
        dateTitle.numberOfLines = 0
        dateTitle.adjustsFontSizeToFitWidth = true
        dateTitle.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
    }
    
    // Конфигуратор поля отображений стоимости доллара
    func configureValueTitle(){
        valueTitle.numberOfLines = 0
        valueTitle.adjustsFontSizeToFitWidth = true
        valueTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
    }
    
    // Констрейнты поля отображения стоимости доллара
    func setDateTitleConstraints(){
        dateTitle.translatesAutoresizingMaskIntoConstraints = false
        dateTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateTitle.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: 0).isActive = true
    }
    
    // Констрейнты поля отображения данных о дате
    func setValueTitleConstraints(){
        valueTitle.translatesAutoresizingMaskIntoConstraints = false
        valueTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        valueTitle.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 0).isActive = true
        valueTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
}
