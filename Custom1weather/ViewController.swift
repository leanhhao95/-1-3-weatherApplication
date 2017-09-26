//
//  ViewController.swift
//  Custom1weather
//
//  Created by Hao on 9/26/17.
//  Copyright © 2017 Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var nameLocal: UILabel!
    @IBOutlet weak var weatherCurrent: UILabel!
    @IBOutlet weak var tempCurrent: UILabel!
    @IBOutlet weak var dayInWeek: UILabel!
    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var tempMax: UILabel!
    @IBOutlet weak var tempMin: UILabel!
    
    
        var weather: Weather? {
            willSet {
                self.weather =  DataService.shared.weather
            }
            didSet {
                
                self.weatherCurrent.text = self.weather?.current.condition.text
                self.nameLocal.text = self.weather?.location.name
                self.dayInWeek.text = self.weather?.forecast.forecastday[0].date_epoch.dayWeek()
                guard let tem = self.weather?.current.temp_c else {return}
                self.tempCurrent.text = ("\(tem) ºC")
                guard let temmax = self.weather?.forecast.forecastday[0].day.maxtemp_c else {return}
                self.tempMax.text = ("\(temmax) ºC")
                guard let temmin = self.weather?.forecast.forecastday[0].day.mintemp_c else {return}
                self.tempMin.text = ("\(temmin) ºC")
                
            }
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: notificationKey, object: nil)
        DataService.shared.requestData()
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updateData() {
        self.weather = DataService.shared.weather
    }
}

