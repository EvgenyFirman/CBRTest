//
//  XMLParser.swift
//  Cbr
//
//  Created by Евгений Фирман on 25.06.2021.
//

import Foundation

// Hotels API Class
class XMLParserClass: NSObject, XMLParserDelegate {
    
    var currentelement: String = ""
    
    var charCode = String()
    var value = String()
    
    var currency: [Currency] = []
    
    struct Currency {
        var charCode: String
        var value: String
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
        
        if elementName == "Valute"{
            charCode = String()
            value = String()
        }
        self.currentelement = elementName
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "Valute" {
            let currency = Currency(charCode: charCode, value: value)
            self.currency.append(currency)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.currentelement == "CharCode" {
            charCode += string
        } else if self.currentelement == "Value" {
            value += string
        }
    }
}

