//
//  constants.swift
//  rainyshiny
//
//  Created by Khaled Bohout on 1/23/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import Foundation

typealias downloadcomplete = () -> ()


let CURRENT_WEATHER_URL = "https://samples.openweathermap.org/data/2.5/weather?lat=\(Location.ShredInstanc.latitude!)&lon=\(Location.ShredInstanc.londitude!)&appid=b6907d289e10d714a6e88b30761fae22"

let Forecasturl = "https://samples.openweathermap.org/data/2.5/forecast/daily?lat=\(Location.ShredInstanc.latitude!)&lon=\(Location.ShredInstanc.londitude!)&cnt=10&appid=b1b15e88fa797225412429c1c50c122a1"








