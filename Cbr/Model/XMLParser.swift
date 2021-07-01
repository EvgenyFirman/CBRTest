//  XMLParser.swift
//  Cbr
//  Created by Евгений Фирман on 25.06.2021.

import UIKit

protocol CurrencyDelegate{
    
    func didUpdateCurrency(currency: [Currency])
}

// XML Parser Class
class XMLParserClass: NSObject, XMLParserDelegate {
    
    var currentElement: String = ""
    
    var value = String()
    
    var dateVar = String()
    
    var delegate: CurrencyDelegate?
    
    var currency: [Currency] = []
    
    // Функция для установки URL с помощью динамической даты 
    func URLSetter() {
        
        let firstParam = startOfMonth()
        
        let secondParam = currentDay()
        
        let string: String? = "https://cbr.ru/scripts/XML_dynamic.asp?date_req1=\(firstParam)&date_req2=\(secondParam)&VAL_NM_RQ=R01235"
        
        
        if let safeString = string {
        
            XMLApiCall(safeString)
            print(string)
        }
    }
    
    func XMLApiCall(_ url: String) {
        
        if let url = URL(string: url){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data,urlResponse,error)  in
                
                if error == nil {
                    
                    if let safeData = data {
                        
                        let parser = XMLParser(data: safeData)
                        
                        parser.delegate = self
                        
                        parser.parse()
                        
                        self.delegate?.didUpdateCurrency(currency: self.currency)
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    // Функция определения начала месяца
    func startOfMonth() -> String{
        let dateFormatter = DateFormatter()
        let date = NSDate()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date as Date)
        guard let month = components.month else { return "01"}
        guard let year = components.year else { return "2021"}
        return "01/0\(month)/\(year)"
    }
    // Функция определения текущего дня
    func currentDay() -> String{
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        if day < 10 {
            return "0\(day)/0\(month)/\(year)"
        } else {
            return "\(day)/0\(month)/\(year)"
        }
       
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "Record"{
            
            value = String()
            
            dateVar = String()
            
            if let date = attributeDict["Date"]{
                
                dateVar = date
                
            }
        }
        
        self.currentElement = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "Record" {
            
            let currency = Currency(date: dateVar, value: value)
            
            self.currency.append(currency)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.currentElement == "Value" {
            
            value += string
        }
    }
}


