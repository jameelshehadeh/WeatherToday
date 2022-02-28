//
//  CilmateManager.swift
//  WeatherToday
//
//  Created by Jameel Shehadeh on 26/02/2022.
//

import Foundation

protocol ClimateManagerDelegate {
    func getWeather(with weather : ClimateData)
}

struct ClimateManager {
    
    var delegate : ClimateManagerDelegate?

    func fetchClimate(){
        
        guard let weatherDataFilePath = Bundle.main.path(forResource: "Climate", ofType: "json") else {
            print("Error getting file path of climate.json")
            return
        }
        
        do {
            let weatherData = try Data(contentsOf: URL(fileURLWithPath: weatherDataFilePath))
            
            guard let climateData = parseJSON(weatherData: weatherData) else {
                return
            }
            delegate?.getWeather(with: climateData)
        }
        
        catch {
            print("couldn't fetch weather data")
        }
    
    }
    
    func parseJSON(weatherData : Data)->ClimateData?{
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(ClimateData.self, from: weatherData)
            return decodedData
        }
        catch {
            print("error decoding JSON")
            return nil
        }
        
    }
    
}
