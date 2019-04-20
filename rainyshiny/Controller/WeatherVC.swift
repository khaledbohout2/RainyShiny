//
//  WeatherVC.swift
//  rainyshiny
//
//  Created by Khaled Bohout on 1/20/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate {
    
    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var currenttemplabel: UILabel!
    @IBOutlet weak var locationlabel: UILabel!
    @IBOutlet weak var currentweatherimage: UIImageView!
    @IBOutlet weak var currentweathertypelabel: UILabel!
    @IBOutlet weak var tableview: UITableView!
    
    var locationManager = CLLocationManager()
    var currentlocation:CLLocation!
    
    var currentweather : CurrentWeather!
    var forecast : ForeCast!
    var forcasts = [ForeCast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableview.delegate = self
        tableview.dataSource = self
        
        currentweather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func authorizelocationstates(){
        
            currentlocation = locationManager.location
            Location.ShredInstanc.latitude = currentlocation.coordinate.latitude
            Location.ShredInstanc.londitude = currentlocation.coordinate.longitude

            currentweather.downloadweatherdetails {
                self.downloadforecastdata {
                    self.UpdateUI()
                }
            }
        }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager = manager
        // Only called when variable have location data
        authorizelocationstates()
    }
    
    func downloadforecastdata(completed: @escaping downloadcomplete){
        
        AF.request(Forecasturl, method: .get).responseJSON{ response in
            let result = response.result
            if let dict = result.value as? Dictionary<String,AnyObject>{
                
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                    for obj in list {
                        let forecast = ForeCast(weatherDict: obj)
                        self.forcasts.append(forecast)
                        
                    }
                    self.forcasts.remove(at: 0)
                    self.tableview.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
            
            let forecast = forcasts[indexPath.row]
            cell.configurecell(forecast: forecast)
            return cell
        }
        else{
            return WeatherCell()
            
        }
        
    }
    
    func UpdateUI(){
        datelabel.text = currentweather.date
        currenttemplabel.text = "\(currentweather.currenttemp)"
        currentweathertypelabel.text = currentweather.weathertype
        locationlabel.text = currentweather.cityname
        currentweatherimage.image = UIImage(named: currentweather.weathertype)
    }
    
}



