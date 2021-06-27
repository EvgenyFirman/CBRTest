//  XMLParser.swift
//  Cbr
//  Created by Евгений Фирман on 25.06.2021.

import Foundation

// XML Parser Class
class XMLParserClass: NSObject, XMLParserDelegate {
    
    var currentElement: String = ""
    
    var value = String()
    
    var dateVar = String()
    
    var currency: [Currency] = []
    
    struct Currency {
        var date: String
        var value: String
    }
    
    func URLSetter() {
        
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
                        
                        print(self.currency)
                    }
                }
            }
            task.resume()
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

