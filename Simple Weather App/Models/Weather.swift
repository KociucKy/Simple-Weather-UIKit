import Foundation

struct Weather: Codable{
    let main: [Main]
    let wind: [Wind]
    let coord: [Coord]
}

struct Main: Codable{
    let humidity: Int
    let temp: Double
}

struct Wind: Codable{
    let speed: Int
}

struct Coord: Codable{
    let lon: Double
    let lat: Double
}
