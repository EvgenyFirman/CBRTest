//
//  TableViewCell.swift
//  Cbr
//
//  Created by Евгений Фирман on 27.06.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var dateTitle = UILabel()
    
    var valueTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    func set(currency: Currency){
        
        dateTitle.text = currency.date
        
        valueTitle.text = currency.value
    }
    func configureDateTitle(){
        dateTitle.numberOfLines = 0
        dateTitle.adjustsFontSizeToFitWidth = true
        dateTitle.font = dateTitle.font.withSize(20)
    }
    
    func configureValueTitle(){
        valueTitle.numberOfLines = 0
        valueTitle.adjustsFontSizeToFitWidth = true
        dateTitle.font = dateTitle.font.withSize(20)
        
    }
    
    func setDateTitleConstraints(){
        dateTitle.translatesAutoresizingMaskIntoConstraints = false
        dateTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dateTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dateTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    func setValueTitleConstraints(){
        valueTitle.translatesAutoresizingMaskIntoConstraints = false
        valueTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        valueTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        valueTitle.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

}
