//
//  ClimateModel.swift
//  WeatherToday
//
//  Created by Jameel Shehadeh on 26/02/2022.
//

import Foundation
import UIKit

struct ClimateModel {
    
    let cityName : String
    let country : String
    let lat : Double
    let long : Double
    var temp : Float
    let minTemp : Float
    let maxTemp : Float
    let description : String
    
    var unit : String
    
    var weatherStatusName : String {
        switch description {
        case "Sunny":
            return "sun.max.fill"
        case "Cloudy":
            return "cloud"
        case "Storms":
            return "cloud.bolt.rain.fill"
        case "Drizzle":
            return "cloud.drizzle"
        case "Overcast":
            return "cloud"
        default: return "cloud"
            
        }
    }
    
    var temprature : Float {

        switch unit {
        case "℃" :
            return  temp
        case "℉" :
            return (temp*9/5) + 32
        default:
            return 0.0
        }
    }
    
    var maxTemprature : Float {

        switch unit {
        case "℃" :
            return  maxTemp
        case "℉" :
            return (maxTemp*9/5) + 32
        default:
            return 0.0
        }
    }

    var minTemprature : Float {

        switch unit {
        case "℃" :
            return  minTemp
        case "℉" :
            return (minTemp*9/5) + 32
        default:
            return 0.0
        }
    }
    
    var tempInFahrenheit : Float {
        return (temp*9/5) + 32
    }
    
    var formattedTempratureString : String {
        return String(format: "%.0f", temprature)
    }
    
    var formattedMaxTempratureString : String {
        return String(format: "%.0f", maxTemprature)
    }
    
    var formattedMinTempratureString : String {
        return String(format: "%.0f", minTemprature)
    }
    
    var detailedWeatherDescription : String {
        return "Weather is expected to be \(description) with a maximum temprature of \(formattedMaxTempratureString)°"
    }
    
}




