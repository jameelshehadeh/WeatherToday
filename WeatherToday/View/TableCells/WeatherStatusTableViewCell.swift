//
//  WeatherStatusTableViewCell.swift
//  WeatherToday
//
//  Created by Jameel Shehadeh on 26/02/2022.
//

import UIKit

class WeatherStatusTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherStatusImageView: UIImageView!
    
    @IBOutlet weak var minTempView: UIView!
    
    @IBOutlet weak var maxTempView: UIView!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var tempratureLabel: UILabel!
    
    @IBOutlet weak var internalView: UIView!
    
    @IBOutlet weak var minTempValueLabel: UILabel!
    
    @IBOutlet weak var maxTempValueLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var minTempLabel: UILabel!
    
    @IBOutlet weak var weatherShortDescriptionLabel: UILabel!
    
    let shapeLayer1 = CAShapeLayer()
    let shapeLayer2 = CAShapeLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        internalView.layer.cornerRadius = 12
        minTempLabel.adjustsFontSizeToFitWidth = true
        maxTempLabel.adjustsFontSizeToFitWidth = true
        weatherShortDescriptionLabel.adjustsFontSizeToFitWidth = true
        weatherDescriptionLabel.adjustsFontSizeToFitWidth = true
    }
    
    func animateTempratureIndicators(minTemp : Float , maxTemp : Float ){
        
        // Calculated based on the highest recorded temperature on earth which is 56.7°C
    
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer2.fillColor = UIColor.clear.cgColor
        
        let centerPoint1 = CGPoint(x: minTempView.frame.width/2, y: minTempView.frame.height/2)
        
        let centerPoint2 = CGPoint(x: maxTempView.frame.width/2, y: maxTempView.frame.height/2)
        
        let circularPath1 = UIBezierPath(arcCenter: centerPoint1, radius: 25 , startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        let circularPath2 = UIBezierPath(arcCenter: centerPoint2, radius: 25, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer1.path = circularPath1.cgPath
        shapeLayer1.strokeColor = UIColor.systemPink.cgColor
        shapeLayer1.lineWidth  = 5
        shapeLayer1.strokeEnd = 0
        
        shapeLayer2.path = circularPath2.cgPath
        shapeLayer2.strokeColor = UIColor.systemPink.cgColor
        shapeLayer2.lineWidth  = 5
        shapeLayer2.strokeEnd = 0
        
        minTempView.layer.addSublayer(shapeLayer1)
        maxTempView.layer.addSublayer(shapeLayer2)
        
        let basicAnimation1 = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation1.toValue = 1*(minTemp/56.7)
        basicAnimation1.duration = 1
        basicAnimation1.fillMode = .forwards
        
        let basicAnimation2 = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation2.toValue = 1*(maxTemp/56.7)
        basicAnimation2.duration = 1
        basicAnimation2.fillMode = .forwards
        
        basicAnimation1.isRemovedOnCompletion = false
        basicAnimation2.isRemovedOnCompletion = false
        
        shapeLayer1.add(basicAnimation1, forKey: "minTemp")
        shapeLayer2.add(basicAnimation2, forKey: "maxTemp")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    static func nibName()-> UINib {
        return UINib(nibName: "WeatherStatusTableViewCell", bundle: nil)
    }
    
    override func prepareForReuse() {
    
    }
    
    func configureCell(with climateModel: ClimateModel) {
        
        switch climateModel.unit {
            case "℃" :
            tempratureLabel.text = "\(climateModel.formattedTempratureString)°C"
            case "℉" :
            tempratureLabel.text = "\(climateModel.formattedTempratureString)°F"
            default:
                print("Invalid temprature unit")
        }
        
        
        cityNameLabel.text = "\(climateModel.cityName), \(climateModel.country)"
//        tempratureLabel.text = "\(climateModel.formattedTempratureString)°C"
        weatherStatusImageView.image = UIImage(systemName: climateModel.weatherStatusName)
        weatherDescriptionLabel.text = climateModel.detailedWeatherDescription
        minTempValueLabel.text = "\(climateModel.formattedMinTempratureString)°"
        maxTempValueLabel.text = "\(climateModel.formattedMaxTempratureString)°"
        weatherShortDescriptionLabel.text = climateModel.description
        animateTempratureIndicators(minTemp: climateModel.minTemp, maxTemp: climateModel.maxTemp)
        
    }
    
}
