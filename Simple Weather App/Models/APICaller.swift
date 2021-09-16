import Foundation

struct APICaller{
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=359d8c826618ad811f70758d3cdf64c1&units=metric&q="
    
    func createURLString(city: String){
        let URLString = baseURL + city
        print(URLString)
        fetchCurrentWeatherData(URLString: URLString)
    }
    
    func fetchCurrentWeatherData(URLString: String){
        let url = URL(string: URLString)
        if let url = url{
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, _, error in
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    if let safeData = data{
                        print("Got the data sir")
                        fetchJSON(data: safeData)
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchJSON(data: Data) -> CurrentWeatherModel?{
       let decoder = JSONDecoder()

        do{
            let decodedData = try decoder.decode(CurrentWeatherData.self, from: data)
            let conditionId = decodedData.weather[0].id
            let cityName = decodedData.name
            let temperature = decodedData.main.temp
            let wind = decodedData.wind.speed
            let humidity = decodedData.main.humidity
            let description = decodedData.weather[0].description
            
            let currentWeather = CurrentWeatherModel(conditionId: conditionId, cityName: cityName, temperature: temperature, wind: wind, humidity: humidity, description: description)
            return currentWeather
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
}
