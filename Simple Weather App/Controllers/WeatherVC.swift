import UIKit
import CoreLocation

class WeatherVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var localizationTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var airPollutionButton: UIButton!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    
    
    //MARK: - Properties
    var locationManager             = CLLocationManager()
    var latitude: Double            = 0.0
    var longitude: Double           = 0.0
    var pollutionStatus             = ""
    var forecastList: [ForecastList] = []
    
    //MARK: - VC Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureCollectionView()
    }
    
    
    //MARK: - Actions
    @IBAction func airPollutionStatusPressed(_ sender: UIButton) {
        self.displayAnAlert(title: "Air Pollution Status", message: self.pollutionStatus, action: "Ok")
    }
    
    @IBAction func localizeMePressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    
    //MARK: - Methods
    func configureVC(){
        localizationTextField.delegate      = self
        locationManager.delegate            = self
        forecastCollectionView.delegate     = self
        forecastCollectionView.dataSource   = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        imageShadow(weatherImage)
        buttonShadow(airPollutionButton)
        
    }
    
    
    func configureCollectionView(){
        let layout                                  = UICollectionViewFlowLayout()
        layout.scrollDirection                      = .horizontal
        forecastCollectionView.collectionViewLayout = layout
        forecastCollectionView.backgroundColor      = .clear
        forecastCollectionView.register(ForecastCell.self, forCellWithReuseIdentifier: ForecastCell.reuseID)
    }
    
    
    //MARK: - Network calls
    func getWeather(city: String){
        NetworkManager.shared.getWeather(for: city) {[weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.cityLabel.text         = weather.name
                    self.temperatureLabel.text  = String(format: "%.1f", weather.main.temp) + " °C"
                    self.humidityLabel.text     = "\(weather.main.humidity)%"
                    self.windLabel.text         = "\(weather.wind.speed) km/h"
                    self.weatherLabel.text      = weather.weather[0].description.capitalized
                    self.weatherImage.image     = UIImage(systemName: self.getWeatherIcon(id: weather.weather[0].id))
                    self.latitude               = weather.coord.lat
                    self.longitude              = weather.coord.lon
                    self.getAirConditionStatus(lon: self.longitude, lat: self.latitude)
                }
            case .failure(let error):
                self.displayAnAlert(title: "Bad Stuff Happend", message: error.rawValue, action: "Ok")
            }
        }
    }
    
    
    func getWeather(lat: Double, lon: Double){
        NetworkManager.shared.getWeather(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.cityLabel.text         = weather.name
                    self.temperatureLabel.text  = String(format: "%.1f", weather.main.temp) + " °C"
                    self.humidityLabel.text     = "\(weather.main.humidity)%"
                    self.windLabel.text         = "\(weather.wind.speed) km/h"
                    self.weatherLabel.text      = weather.weather[0].description.capitalized
                    self.weatherImage.image     = UIImage(systemName: self.getWeatherIcon(id: weather.weather[0].id))
                    self.latitude               = weather.coord.lat
                    self.longitude              = weather.coord.lon
                    self.getAirConditionStatus(lon: self.longitude, lat: self.latitude)
                }
            case .failure(let error):
                self.displayAnAlert(title: "Bad Stuff Happend", message: error.rawValue, action: "Ok")
            }
        }
    }
    
    
    func getAirConditionStatus(lon: Double, lat: Double){
        NetworkManager.shared.getAirConditionStatus(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let airData):
                self.pollutionStatus = self.getAirStatus(id: airData.list[0].main.aqi)
            case .failure(let error):
                self.displayAnAlert(title: "Bad Stuff Happend", message: error.rawValue, action: "Ok")
            }
            
        }
    }
    
    
    func getForecast(city: String){
        NetworkManager.shared.getForecastWeather(for: city) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
            case .success(let forecastWeather):
                self.forecastList = []
                let list = forecastWeather.list
                self.forecastList.append(contentsOf: list)
                DispatchQueue.main.async { self.forecastCollectionView.reloadData() }
            case .failure(let error):
                DispatchQueue.main.async { self.displayAnAlert(title: "Bad Stuff Happend", message: error.rawValue, action: "Ok") }
            }
        }
    }
    
    
    func getForecast(lat: Double, lon: Double){
        NetworkManager.shared.getForecastWeather(lat: lat, lon: lon) { [weak self] result in
            guard let self = self else { return }
            
            
            switch result{
            case .success(let forecastWeather):
                self.forecastList = []
                let list = forecastWeather.list
                self.forecastList.append(contentsOf: list)
                DispatchQueue.main.async { self.forecastCollectionView.reloadData() }
            case .failure(let error):
                DispatchQueue.main.async { self.displayAnAlert(title: "Bad Stuff Happend", message: error.rawValue, action: "Ok") }
            }
        }
    }
    
    
    func getWeatherIcon(id: Int) -> String{
        switch id {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 700...771:
            return "cloud.fog"
        case 781:
            return "tornado"
        case 800:
            return "sun.max"
        case 801...802:
            return "cloud.sun"
        case 803...804:
            return "cloud"
        default:
            return "cloud.sun"
        }
    }
    
    
    func getAirStatus(id: Int) -> String{
        switch id{
        case 1:
            return "The air condition is good."
        case 2:
            return "The air condition is fair."
        case 3:
            return "The air condition is moderate."
        case 4:
            return "The air condition is poor."
        case 5:
            return "The air condition is very poor."
        default:
            return "We couldn't get the air condition status."
        }
    }
}


//MARK: - UICollectionView DataSource and Delegate Methods
extension WeatherVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: ForecastCell.reuseID, for: indexPath) as! ForecastCell
        cell.backgroundColor        = .clear
        cell.weatherImage.image     = UIImage(systemName: getWeatherIcon(id: self.forecastList[indexPath.row].weather[0].id))
        cell.set(list: forecastList, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: forecastCollectionView.frame.width / 2.5, height: forecastCollectionView.frame.height)
    }
}


//MARK: - UITextField Delegate Methods
extension WeatherVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        localizationTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else{
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //making sure that names like "New York" do not return an error
        if let city = localizationTextField.text?.replacingOccurrences(of: " ", with: "%20"){
            getWeather(city: city)
            getForecast(city: city)
        }
        localizationTextField.text = ""
    }
}


//MARK: - CLLocationManager Delegate Methods
extension WeatherVC: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            getWeather(lat: lat, lon: lon)
            getForecast(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.displayAnAlert(title: "Bad Stuff Happend", message: "We couldn't get your current location.", action: "Ok")
    }
}


