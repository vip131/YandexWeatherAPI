//
//  ViewController.swift
//  YandexWeatherAPI
//
//  Created by Admin on 10.01.2021.
//  Copyright © 2021 DmitryChaschin. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var textView: UITextView! 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let weatherFx = WeatherFx()
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    let nameArray = ["ощущается как","давление мм."]
    let supportFunctions = SupportClass()
    private let reuseIdentifierForCellWithSubtitle = "cellIdentifier"
    
    var forecast = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(SubtitleCell.self, forCellReuseIdentifier: self.reuseIdentifierForCellWithSubtitle)
        self.activityIndicator.startAnimating()
        self.activityIndicator.color = .systemTeal
        self.activityIndicator.hidesWhenStopped = true
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
        
        weatherManager.delegate = self
        searchTextField.placeholder = "город или область"
        searchTextField.delegate = self
        textView.layer.cornerRadius = 15
        //textView.backgroundColor = #colorLiteral(red: 0.7125448585, green: 0.8388879895, blue: 0.9329840541, alpha: 1)
        view.backgroundColor = .white
        image.layer.cornerRadius = 5
    }
    
    @IBAction func searchTextField(_ sender: UITextField) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func geotargetButton(_ sender: UIButton) {
        self.activityIndicator.startAnimating()
        locationManager.requestLocation()
    }
}

//MARK: - UITextFieldDelegate -
extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        //
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let searchCity = textField.text {
            SupportClass.getCoorditateFrom(string: searchCity) { (coordinate, error) in
                guard let coordinate = coordinate else { return }
                self.weatherManager.fechWeather(from: coordinate)
                textField.resignFirstResponder()
                textField.text = ""
            }
            return true
        }
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       // return SupportClass.check(string: string)
        return true
    }
}

extension ViewController: WeatherDataDelegate {
    func updateData(_ withManager: WeatherManager, withModel: WeatherModel) {
        DispatchQueue.main.async {
            let temperature = withModel.temperature
            self.temperatureLabel.text = "\(temperature)ºC"
            self.cityNameLabel.text = withModel.name
            //self.weatherImage.image = UIImage(systemName: withModel.conditionIcon, withConfiguration: nil)
            self.forecast = [withModel.feelsLike, withModel.pressure]
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
            self.image.image = self.supportFunctions.setImageRelativeTo(daytime: withModel.daytime, temp: temperature)
            //change image
//            if (temperature > 15){
//                self.image.image = UIImage(named: "summer")
//                self.weatherFx.letItRain(on: self.image)
//            } else {
//                if withModel.daytime == "d"{
//                self.image.image = UIImage(named: "winter")
//                self.weatherFx.letItSnow(on: self.image)
//                } else {
//                    self.image.image = UIImage(named: "winterNight")
//                                   self.weatherFx.letItSnow(on: self.image)
//                }
            //}
        }
    }
}


extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last?.coordinate else { return }
        print(location)
        self.weatherManager.fechWeather(from: location)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

//MARK: - TableViewDelegate -

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierForCellWithSubtitle, for: indexPath)
        cell.textLabel?.text = (forecast[indexPath.row])
        cell.detailTextLabel?.text = nameArray[indexPath.row]
        cell.detailTextLabel?.textColor = .black
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.isUserInteractionEnabled = false
               return cell
    }

}


class SubtitleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder:) has not been implemented")
    }
    
}
