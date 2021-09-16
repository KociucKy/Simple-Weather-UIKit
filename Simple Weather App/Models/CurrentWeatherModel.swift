import Foundation

struct CurrentWeatherModel{
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let wind: Double
    var windString: String{
        return String(format: "%.1f", wind)
    }
    let humidity: Double
    var humidityString: String{
        return String(format: "%.1f", humidity)
    }
    let description: String
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.heavyrain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 700...771:
            return "cloud.fog.fill"
        case 781:
            return "tornado"
        case 800:
            return "sun.max.fill"
        case 801...802:
            return "cloud.sun.fill"
        case 803...804:
            return "cloud.fill"
        default:
            return "cloud.sun.fill"
        }
    }
}
