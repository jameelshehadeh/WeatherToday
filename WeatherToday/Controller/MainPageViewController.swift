//
//  MainPageViewController.swift
//  WeatherToday
//
//  Created by Jameel Shehadeh on 26/02/2022.
//

import UIKit

class MainPageViewController: UIViewController {
    
    var weatherCells = [ClimateModel]()
    
    var weatherManager = ClimateManager()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherStatusTableViewCell.nibName(), forCellReuseIdentifier: "WeatherCell")
        return tableView
    }()
    
    private let tempUnitSegmentedControl : UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["℃","℉"])
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        weatherManager.delegate = self
        tableView.tintColor = .systemPink
        
        // TableView
        tableView.separatorStyle = .none
        tableView.tableHeaderView = createTableViewHeader()
        view.addSubview(tableView)
        
        // tempUnitSegmentedControl
        tempUnitSegmentedControl.selectedSegmentIndex = 0
        tempUnitSegmentedControl.selectedSegmentTintColor = .systemPink
        tempUnitSegmentedControl.addTarget(self, action: #selector(didChangeSegmentedControlValue), for: .valueChanged)
    
        weatherManager.fetchClimate()
    
    }
    
    func createTableViewHeader()->UIView {
        
        let headerView = UIView()
        let todaysLabel = UILabel()
        let date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter .timeZone = .current
        dateFormatter .locale = .current
        dateFormatter .dateFormat = "MMMM, d yyyy"

        let formattedDate = dateFormatter .string(from: date)
        
        todaysLabel.font = .systemFont(ofSize: 17, weight: .bold)
        todaysLabel.textAlignment = .left
        todaysLabel.adjustsFontSizeToFitWidth = true
        todaysLabel.text = formattedDate

        headerView.backgroundColor = .systemPink
        
        let stackView = UIStackView(arrangedSubviews: [todaysLabel,tempUnitSegmentedControl])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        headerView.addSubview(stackView)
        
        headerView.addSubview(stackView)
        headerView.frame = CGRect(x: 0 , y: 0 , width: view.frame.width , height: 50)
        stackView.frame = CGRect(x: 20  , y: 0, width: view.frame.width - 40, height: headerView.frame.height)
        headerView.layer.cornerRadius = 12
    
        return headerView
    }
    
    @objc func didChangeSegmentedControlValue() {
        
        guard let selectedUnit = tempUnitSegmentedControl.titleForSegment(at: tempUnitSegmentedControl.selectedSegmentIndex) else {
            return
        }
        print("selected unit is \(selectedUnit)")
        switch selectedUnit {
        case "℃" :
            print("case if C")
            weatherCells = []
            weatherManager.fetchClimate()
            tableView.reloadData()
        case "℉" :
            print("case if F")
            weatherCells = []
            weatherManager.fetchClimate()
            tableView.reloadData()
        default:
            print("No valid unit selected")
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
}

//MARK: - UITableView delegate/datasource

extension MainPageViewController : UITableViewDelegate , UITableViewDataSource {

    // Datasource methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let climateModel = weatherCells[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell" , for: indexPath) as! WeatherStatusTableViewCell
        cell.selectionStyle = .none
        cell.configureCell(with: climateModel)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherCells.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Delegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

//MARK: - ClimateManagerDelegate

extension MainPageViewController : ClimateManagerDelegate {

    func getWeather(with weather: ClimateData) {
        
        guard let selectedUnit = tempUnitSegmentedControl.titleForSegment(at: tempUnitSegmentedControl.selectedSegmentIndex) else {
            print("Invalid temprature unit")
            return
        }

        let citiesWeatherList = weather.cities
        
        for cityWeather in citiesWeatherList {
            let climateModel = ClimateModel(cityName: cityWeather.name, country: cityWeather.country, lat: cityWeather.lat, long: cityWeather.long, temp: cityWeather.temp, minTemp: cityWeather.minTemp, maxTemp: cityWeather.maxTemp, description: cityWeather.shortDescription, unit: selectedUnit)
            weatherCells.append(climateModel)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

}
