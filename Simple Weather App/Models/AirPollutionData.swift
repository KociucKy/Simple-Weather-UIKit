import Foundation

struct AirPollutionData: Codable{
    let list: [List]
}

struct List: Codable{
    let main: MainAir
}

struct MainAir: Codable{
    let aqi: Int
}

