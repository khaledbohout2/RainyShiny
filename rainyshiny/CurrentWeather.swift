//
//  currentweather.swift
//  rainyshiny
//
//  Created by Khaled Bohout on 1/23/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    private var _cityname:String!
    private var _date:String!
    private var _weathertype:String!
    private var _currenttemp:Double!
    
    var cityname:String {
        if _cityname == nil {
            _cityname = ""
        }
        return _cityname
    }
    var date:String {
        if _date == nil {
            _date = ""
        }
        let dataformatter = DateFormatter()
        dataformatter.dateStyle = .long
        dataformatter.timeStyle = .none
        let currentdate = dataformatter.string(from: Date())
        self._date = "Today\(currentdate)"
        return _date
    }
    var weathertype:String {
        if _weathertype == nil {
            _weathertype = ""
        }
        return _weathertype
    }
    var currenttemp:Double {
        if _currenttemp == nil {
            _currenttemp = 0.0
        }
        return _currenttemp
    }
    
    func downloadweatherdetails(completed:@escaping downloadcomplete)
    {
        //tell alomofire where to download from
        
        AF.request(CURRENT_WEATHER_URL, method: .get).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let name = dict["name"] as? String {
                    self._cityname = name.capitalized
                }
                if let weather = dict["weather"] as? [Dictionary<String,AnyObject>]{
                    if let main = weather[0]["main"] as? String {
                        self._weathertype = main.capitalized
                    }
                }
                if let main = dict["main"]as?Double {
                    let tempinkelvin = main
                    let currenttemp = ((tempinkelvin * (9/5)) - 459.67)
                    self._currenttemp = currenttemp
                }
                
            }
                    completed()
        }

    }
}








