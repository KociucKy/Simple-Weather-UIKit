import Foundation
import CoreLocation

protocol APICallerDelegate{
    func didFinishWithError(error: Error)
    func didGetCurrentWeather(_ apiCaller: APICaller, model: CurrentWeatherModel)
}

struct APICaller{
    //MARK: - Properties
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=359d8c826618ad811f70758d3cdf64c1&units=metric"
    var delegate: APICallerDelegate?
    
    //MARK: - Methods
    func createURLString(city: String){
        let URLString = "\(baseURL)&q=\(city)"
        fetchCurrentWeatherData(URLString: URLString)
    }
    
    func createURLString(longitude: CLLocationDegrees, latitude: CLLocationDegrees){
        let URLString = "\(baseURL)&lat=\(latitude)&lon=\(longitude)"
        fetchCurrentWeatherData(URLString: URLString)
    }
    
    func fetchCurrentWeatherData(URLString: String){
        let url = URL(string: URLString)
        if let url = url{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if let e = error{
                    self.delegate?.didFinishWithError(error: e)
                    return
                }else{
                    if let safeData = data{
                        if let currentWeather = self.parseJSON(data: safeData){
                            self.delegate?.didGetCurrentWeather(self, model: currentWeather)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> CurrentWeatherModel?{
       let decoder = JSONDecoder()

        do{
            let decodedData = try decoder.decode(CurrentWeatherData.self, from: data)
            let conditionId = decodedData.weather[0].id
            let cityName = decodedData.name
            let temperature = decodedData.main.temp
            let wind = decodedData.wind.speed
            let humidity = decodedData.main.humidity
            let description = decodedData.weather[0].description.capitalized
            
            let currentWeather = CurrentWeatherModel(conditionId: conditionId, cityName: cityName, temperature: temperature, wind: wind, humidity: humidity, description: description)
            return currentWeather
        }catch{
            self.delegate?.didFinishWithError(error: error)
            return nil
        }
    }
}
