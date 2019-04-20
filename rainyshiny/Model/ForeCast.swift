//
//  forecast.swift
//  rainyshiny
//
//  Created by Khaled Bohout on 1/24/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import Alamofire

class ForeCast {
    private var _date : String!
    private var _weathertype : String!
    private var _hightemp : String!
    private var _lowtemp : String!
    
    var date:String {
        if _date == nil{
            _date = ""
        }
        return _date
        
    }
    var weathertype:String {
        if _weathertype == nil{
            _weathertype = ""
        }
        return _weathertype
        
    }
    var hughtemp:String {
        if _hightemp == nil{
            _hightemp = ""
        }
        return _hightemp
        
    }
    var lowtemp:String {
        if _lowtemp == nil{
            _lowtemp = ""
        }
        return _lowtemp
        
    }
    
     init(weatherDict: Dictionary<String, AnyObject>) {
        if let temp = weatherDict["temp"]as? Dictionary<String,AnyObject>{
            if let min = temp["min"]as? Double {
              let kelvinToFarenheit = ((min * (9/5)) - 459.67)
                let currenttemp = Double(round(10 * kelvinToFarenheit/10))
                self._lowtemp = "\(currenttemp)"
            }
            if let max = temp["max"] as? Double{
                let kelvinToFarenheit = ((max * (9/5)) - 459.67)
                let currenttemp = Double(round(10 * kelvinToFarenheit/10))
                self._hightemp = "\(currenttemp)"
            }
        }
        if let weather = weatherDict["weather"]as?[Dictionary<String,AnyObject>]{
            if let main = weather[0]["main"]as? String{
                self._weathertype = main
            }
        }
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
}

}

extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
