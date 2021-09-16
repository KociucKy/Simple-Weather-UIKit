import Foundation

struct CurrentWeatherData: Codable{
    let name: String
    let wind: Wind
    let main: Main
    let weather: [Weather]
}

struct Wind: Codable{
    let speed: Double
}

struct Main: Codable{
    let temp: Double
    let humidity: Double
}

struct Weather: Codable{
    let id: Int
    let description: String
}
