//
//  ClimateModel.swift
//  WeatherToday
//
//  Created by Jameel Shehadeh on 26/02/2022.
//

import Foundation

struct ClimateData : Decodable {
    
    let cities : [cityWeatherData]
        
}

struct cityWeatherData : Decodable {
    
    let name : String
    let country : String
    let lat : Double
    let long : Double
    let temp : Float
    let minTemp : Float
    let maxTemp : Float
    let shortDescription : String
    
}
