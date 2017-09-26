//
//  Dataservice.swift
//  Custom1weather
//
//  Created by Hao on 9/26/17.
//  Copyright © 2017 Hao. All rights reserved.
//

import Foundation

let notificationKey = Notification.Name.init("requestAPI")

class DataService {
    static let shared: DataService = DataService()
    let urlString = "https://api.apixu.com/v1/forecast.json?key=52fa8b8fbd6e45ab95a83554172609&q=hanoi&days=7"
    private var _weather: Weather?
    var weather: Weather? {
        get {
            if _weather == nil {
                requestData()
            }
            return _weather
        } set {
            _weather = newValue
        }
    }
    

    
    
    func requestData() {
        guard let url = URL(string: urlString) else { return }
        let requestURL = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: requestURL) { (data, response, error) in
            guard error == nil else { return }
            guard data != nil else { return }
            DispatchQueue.main.async {
                self._weather = try? JSONDecoder().decode(Weather.self, from: data!)
                NotificationCenter.default.post(name: notificationKey, object: nil )
            }
        }
        task.resume()
        
    }
    
}


