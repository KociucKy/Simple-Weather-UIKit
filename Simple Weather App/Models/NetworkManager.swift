import Foundation

class NetworkManager{
    public let shared   = NetworkManager()
    private let baseURL = "http://api.openweathermap.org/data/2.5/weather?q="
    
    private init(){}
    
    private func valueForAPIKey(named keyname:String) -> String {
        let filePath    = Bundle.main.path(forResource: "ApiKey", ofType: "plist")
        let plist       = NSDictionary(contentsOfFile:filePath!)
        let value       = plist?.object(forKey: keyname) as! String
        return value
    }
    
    func getWeather(for city: String, completed: @escaping (Result<Weather, CustomErrors>) -> Void){
        let apiKey      = valueForAPIKey(named: "API_CLIENT_ID")
        let endpoint    = baseURL + city + "&appid=\(apiKey)"
        
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
                let weather = try decoder.decode(Weather.self, from: data)
                completed(.success(weather))
            }catch{
                completed(.failure(.invalidData))
            }

        }
        task.resume()
    }
}
