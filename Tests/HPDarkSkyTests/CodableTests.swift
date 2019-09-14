import XCTest
import CoreLocation
@testable import HPDarkSky

final class CodableTests: XCTestCase {
    var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        //encoder.dateEncodingStrategy = .secondsSince1970
        return encoder
    }

    var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        //decoder.dateDecodingStrategy = .secondsSince1970
        return decoder          
    }

    func testAlertCodable() throws {
        let alert = Alert(
            title: "Mock",
            timeStamp: Date.distantPast,
            expires: Date.distantFuture,
            description: "Mock descriptio",
            url: URL(string: "https://google.com")!,
            affectedRegions: ["europe"],
            severity: .warning)

        let data = try encoder.encode(alert)
        let loaded = try decoder.decode(Alert.self, from: data)

        XCTAssertEqual(alert, loaded)
    }

    func testAPIErrorCodable() throws {
        let apiError = APIError(code: 401, error: "Some generic error")

        let data = try encoder.encode(apiError)
        let loaded = try decoder.decode(APIError.self, from: data)

        XCTAssertEqual(apiError, loaded)
    }
    
    func testPrecipitationCodable() throws {
        let precip = Precipitation(intensity: 100, error: nil, probability: 86, type: .sleet, maxIntensity: 300, maxIntensityTime: Date.distantPast, accumulation: 1200)
        
        let data = try encoder.encode(precip)
        let loaded = try decoder.decode(Precipitation.self, from: data)

        XCTAssertEqual(precip, loaded)
    }
    
    func testWindCodable() throws {
        let wind = Wind(speed: 1231.213, gust: 1231.00, bearing: 912, gustTime: Date.distantPast)
        
        let data = try encoder.encode(wind)
        let loaded = try decoder.decode(Wind.self, from: data)

        XCTAssertEqual(wind, loaded)
    }

    func testIconCodable() throws {
        try WeatherIcon.allCases.forEach { icon in
            let data = try encoder.encode(icon)
            let loaded = try decoder.decode(WeatherIcon.self, from: data)

            XCTAssertEqual(icon, loaded)
        }
    }
    
    func testLanguageCodable() throws {
        try Language.allCases.forEach { lang in
            let data = try encoder.encode(lang)
            let loaded = try decoder.decode(Language.self, from: data)

            XCTAssertEqual(lang, loaded)
        }
    }

    func testCurrentDatapointCodable() throws {
        let current = CurrentDatapoint(
            temperature: 10.00,
            cloudCover: 10.1923128,
            dewPoint: 10.1923128,
            humidity: 10.1923128,
            icon: .clearDay,
            ozone: 10.1923128,
            pressure: 10.1923128,
            summary: "Generic description",
            time: Date.distantPast,
            uvIndex: 7,
            visibility: 10.1923128,
            windSpeed: 10.1923128,
            windGust: 10.1923128,
            windBearing: 1,
            windGustTime: Date(),
            precipIntensity: 10.1923128,
            precipIntensityError: nil,
            precipProbability: 10.1923128,
            precipType: .rain,
            precipIntensityMax: nil,
            precipIntensityMaxTime: nil,
            precipAccumulation: nil)

        let data = try encoder.encode(current)
        let loaded = try decoder.decode(CurrentDatapoint.self, from: data)
        XCTAssertEqual(current, loaded)
    }
    
    func testDailyDatapointCodable() throws {
        let datapoint = DailyDatapoint(apparentTemperatureHigh: 10.9123, apparentTemperatureHighTime: Date(), apparentTemperatureLow: 10.9123, apparentTemperatureLowTime: Date(), apparentTemperatureMax: 10.00, apparentTemperatureMaxTime: Date(), apparentTemperatureMin: 120312.1231, apparentTemperatureMinTime: Date(), moonPhase: 202.2, sunriseTime: Date(), sunsetTime: Date(), temperatureHigh: 202.2, temperatureHighTime: Date(), temperatureLow: 202.2, temperatureLowTime: Date(), temperatureMax: 202.2, temperatureMaxTime: Date(), temperatureMin: 202.2, temperatureMinTime: Date(), uvIndexTime: 202.2, cloudCover: 202.2, dewPoint: 202.2, humidity: 202.2, icon: .partlyCloudyDay, ozone: 202.2, pressure: 202.2, summary: "Generic summary", time: Date(), uvIndex: 8, visibility: 102312.2, windSpeed: 202.2, windGust: 202.2, windBearing: 356, windGustTime: nil, precipIntensity: 102312.2, precipIntensityError: 202.2, precipProbability: 102312.2, precipType: .snow, precipIntensityMax: nil, precipIntensityMaxTime: nil, precipAccumulation: 102312.2)

        let data = try encoder.encode(datapoint)
        let loaded = try decoder.decode(DailyDatapoint.self, from: data)
        XCTAssertEqual(datapoint, loaded)
    }

    func testMinutelyForecast() {
        let datapoints = [
            MinutelyDatapoint(
                time: Date(),
                precipIntensity: 10.00,
                precipIntensityError: 12.122,
                precipProbability: 912.0,
                precipType: .rain,
                precipIntensityMax: nil,
                precipIntensityMaxTime: nil,
                precipAccumulation: 012.2)
        ]

        let forecast = Forecast<MinutelyDatapoint>(summary: "asdasldas", icon: .cloudy, data: datapoints)

        do {
            let data = try encoder.encode(forecast)
            let loaded = try decoder.decode(Forecast<MinutelyDatapoint>.self, from: data)
            XCTAssertEqual(forecast, loaded)
        } catch let err {
            XCTFail(err.localizedDescription)
        }
    }

    func testDailyForecast() {
        let datapoints = [
            DailyDatapoint(apparentTemperatureHigh: 10, apparentTemperatureHighTime: Date(), apparentTemperatureLow: 10, apparentTemperatureLowTime: Date(), apparentTemperatureMax: 10.00, apparentTemperatureMaxTime: Date(), apparentTemperatureMin: 120312.1231, apparentTemperatureMinTime: Date(), moonPhase: 202.2, sunriseTime: Date(), sunsetTime: Date(), temperatureHigh: 202.2, temperatureHighTime: Date(), temperatureLow: 202.2, temperatureLowTime: Date(), temperatureMax: 202.2, temperatureMaxTime: Date(), temperatureMin: 202.2, temperatureMinTime: Date(), uvIndexTime: 202.2, cloudCover: 202.2, dewPoint: 202.2, humidity: 202.2, icon: .partlyCloudyDay, ozone: 202.2, pressure: 202.2, summary: "Generic summary", time: Date(), uvIndex: 10, visibility: 102312.2, windSpeed: 202.2, windGust: 202.2, windBearing: 356, windGustTime: nil, precipIntensity: 102312.2, precipIntensityError: 202.2, precipProbability: 102312.2, precipType: .snow, precipIntensityMax: nil, precipIntensityMaxTime: nil, precipAccumulation: 102312.2)
        ]

        let forecast = Forecast<DailyDatapoint>(summary: "asdasldas", icon: .cloudy, data: datapoints)

        do {
            let data = try encoder.encode(forecast)
            let loaded = try decoder.decode(Forecast<DailyDatapoint>.self, from: data)
            XCTAssertEqual(forecast, loaded)
        } catch let err {
            XCTFail(err.localizedDescription)
        }
    }

    static var allTests = [
        ("testAlertCodable", testAlertCodable),
        ("testAPIErrorCodable", testAPIErrorCodable),
        ("testPrecipitationCodable", testPrecipitationCodable),
        ("testWindCodable", testWindCodable),
        ("testIconCodable", testIconCodable),
        ("testCurrentDatapointCodable", testCurrentDatapointCodable),
        ("testDailyDatapointCodable", testDailyDatapointCodable),
        ("testMinutelyForecast", testMinutelyForecast),
        ("testDailyForecast", testDailyForecast)
    ]
}
