import Foundation

class NetworkManager{
    static let shared       = NetworkManager()
    private let baseURL     = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    private let airURL      = "https://api.openweathermap.org/data/2.5/air_pollution?"
    private let forecastURL = "https://api.openweathermap.org/data/2.5/forecast?units=metric"
    
    private init(){}
    
    //COMMENT THIS FUNCTION
    private func valueForAPIKey(named keyname:String) -> String {
        let filePath    = Bundle.main.path(forResource: "ApiKey", ofType: "plist")
        let plist       = NSDictionary(contentsOfFile:filePath!)
        let value       = plist?.object(forKey: keyname) as! String
        return value
    }
    
    func getWeather(for city: String, completed: @escaping (Result<WeatherData, CustomErrors>) -> Void){
        //Replace apiKey value with your OpenWeatherMapAPI Key
        let apiKey      = valueForAPIKey(named: "API_CLIENT_ID")
        let endpoint    = baseURL + "&q=\(city)" + "&appid=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let weather = try decoder.decode(WeatherData.self, from: data)
                completed(.success(weather))
            }catch{
                completed(.failure(.invalidData))
            }

        }
        task.resume()
    }
    
    
    func getWeather(lat: Double, lon: Double, completed: @escaping (Result<WeatherData, CustomErrors>) -> Void){
        let apiKey      = valueForAPIKey(named: "API_CLIENT_ID")
        let endpoint    = baseURL + "&lat=\(lat)" + "&lon=\(lon)" + "&appid=\(apiKey)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }


            do{
                let decoder = JSONDecoder()
                let weather = try decoder.decode(WeatherData.self, from: data)
                completed(.success(weather))
            } catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getAirConditionStatus(lat: Double, lon: Double, completed: @escaping (Result<AirPollutionData, CustomErrors>) -> Void){
        let apiKey      = valueForAPIKey(named: "API_CLIENT_ID")
        let endpoint    = airURL + "&lat=\(lat)" + "&lon=\(lon)" + "&appid=\(apiKey)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error{
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do{
                let decoder     = JSONDecoder()
                let airStatus   = try decoder.decode(AirPollutionData.self, from: data)
                completed(.success(airStatus))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getForecastWeather(for city: String, completed: @escaping(Result<ForecastData, CustomErrors>) -> Void){
        let apiKey      = valueForAPIKey(named: "API_CLIENT_ID")
        let endpoint    = forecastURL + "&q=\(city)" + "&appid=\(apiKey)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let forecastWeather = try decoder.decode(ForecastData.self, from: data)
                completed(.success(forecastWeather))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getForecastWeather(lat: Double, lon: Double, completed: @escaping(Result<ForecastData, CustomErrors>) -> Void){
        let apiKey      = valueForAPIKey(named: "API_CLIENT_ID")
        let endpoint    = forecastURL + "&lat=\(lat)" + "&lon=\(lon)" + "&appid=\(apiKey)"
        
        guard let url = URL(string: endpoint) else{
            completed(.failure(.unableToComplete))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let forecastWeather = try decoder.decode(ForecastData.self, from: data)
                completed(.success(forecastWeather))
            }catch{
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
