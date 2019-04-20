//
//  weathercell.swift
//  rainyshiny
//
//  Created by Khaled Bohout on 1/26/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var weathericon: UIImageView!
    @IBOutlet weak var daylbl: UILabel!
    @IBOutlet weak var weathertypelbl: UILabel!
    @IBOutlet weak var hightemplbl: UILabel!
    @IBOutlet weak var lowtemplbl: UILabel!
    
    func configurecell(forecast:ForeCast){
        lowtemplbl.text = "\(forecast.lowtemp)"
        hightemplbl.text = "\(forecast.hughtemp)"
        weathericon.image = UIImage(named: forecast.weathertype)
        daylbl.text = forecast.date
        weathertypelbl.text = forecast.weathertype
    }
}
