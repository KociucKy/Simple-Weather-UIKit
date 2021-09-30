import Foundation

struct WeatherData: Codable{
    let main: Main
    let wind: Wind
    let coord: Coord
    let weather: [Weather]
    let name: String
}

struct Main: Codable{
    let humidity: Double
    let temp: Double
}

struct Wind: Codable{
    let speed: Double
}

struct Coord: Codable{
    let lon: Double
    let lat: Double
}

struct Weather: Codable{
    let id: Int
    let description: String
}
