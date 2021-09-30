import Foundation

class NetworkManager{
    static let shared   = NetworkManager()
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather?units=metric"
    
    private init(){}
    
    private func valueForAPIKey(named keyname:String) -> String {
        let filePath    = Bundle.main.path(forResource: "ApiKey", ofType: "plist")
        let plist       = NSDictionary(contentsOfFile:filePath!)
        let value       = plist?.object(forKey: keyname) as! String
        return value
    }
    
    func getWeather(for city: String, completed: @escaping (Result<WeatherData, CustomErrors>) -> Void){
        let apiKey      = valueForAPIKey(named: "API_CLIENT_ID")
        let endpoint    = baseURL + "&q=\(city)" + "&appid=\(apiKey)"
        print(endpoint)
        
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
}
