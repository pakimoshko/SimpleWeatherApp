//
//  ViewController.swift
//  weather
//
//  Created by Dmitrii Buiskii on 3/21/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var getWeatherButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        getWeatherButton.addTarget(self, action: #selector(didTapGetWeatherButton), for: .touchUpInside)
        
    }
    
    @objc func didTapGetWeatherButton(){
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=47.3012&longitude=-122.2066&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m"
        let url = URL(string: urlString)!
        let request = URLRequest(url:url)
        let task = URLSession.shared.dataTask(with: request){data, response, error in
            if let data, let weather = try? JSONDecoder().decode(WeatherData.self, from: data){
                DispatchQueue.main.async{
                    self.weatherLabel.text = "temp =\(weather.current.temperature2M)°  \(weather.current.interval)"
                }
                
            } else {
                
                print("Failed!")
                
            }
        }
        task.resume()
    }

}

