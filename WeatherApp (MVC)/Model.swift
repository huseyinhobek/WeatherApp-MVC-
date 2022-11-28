//
//  Model.swift
//  WeatherApp (MVC)
//
//  Created by Hüseyin HÖBEK on 24.11.2022.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather = try? newJSONDecoder().decode(Weather.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.weatherTask(with: url) { weather, response, error in
//     if let weather = weather {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let cod: String?
    let message, cnt: Int?
    let list: [List]?
    let city: City?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.cityTask(with: url) { city, response, error in
//     if let city = city {
//       ...
//     }
//   }
//   task.resume()

// MARK: - City
struct City: Codable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String?
    let population, timezone, sunrise, sunset: Int?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.coordTask(with: url) { coord, response, error in
//     if let coord = coord {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.listTask(with: url) { list, response, error in
//     if let list = list {
//       ...
//     }
//   }
//   task.resume()

// MARK: - List
struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [WeatherElement]?
    let clouds: Clouds?
    let wind: Wind?
    let visibility, pop: Int?
    let sys: Sys?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.cloudsTask(with: url) { clouds, response, error in
//     if let clouds = clouds {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.mainClassTask(with: url) { mainClass, response, error in
//     if let mainClass = mainClass {
//       ...
//     }
//   }
//   task.resume()

// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double?
    let pressure, seaLevel, grndLevel, humidity: Int?
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike
        case tempMin
        case tempMax
        case pressure
        case seaLevel
        case grndLevel
        case humidity
        case tempKf
    }
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.sysTask(with: url) { sys, response, error in
//     if let sys = sys {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Sys
struct Sys: Codable {
    let pod: Pod?
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.weatherElementTask(with: url) { weatherElement, response, error in
//     if let weatherElement = weatherElement {
//       ...
//     }
//   }
//   task.resume()

// MARK: - WeatherElement
struct WeatherElement: Codable {
    let id: Int?
    let main: MainEnum?
    let weatherDescription: Description?
    let icon: Icon?

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription
        case icon
    }
}

enum Icon: String, Codable {
    case the03N = "03n"
    case the04D = "04d"
    case the04N = "04n"
}

enum MainEnum: String, Codable {
    case clouds = "Clouds"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.windTask(with: url) { wind, response, error in
//     if let wind = wind {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Wind
struct Wind: Codable {
    let speed: Double?
    let deg: Int?
    let gust: Double?
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func weatherTask(with url: URL, completionHandler: @escaping (Weather?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
