import XCTest
import CoreLocation
@testable import HPDarkSky

final class CodableTests: XCTestCase {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    func makeRequestObject() -> DarkSkyRequest {
        return DarkSkyRequest(
            secret: TestSecret.secret!,
            location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            date: Date(),
            excludedFields: [],
            units: .metric,
            language: .german)
    }

    func testAlertCodable() throws {
        let alert = Alert(
            title: "Mock",
            timeStamp: Date.distantPast,
            expires: Date.distantFuture,
            description: "Mock description",
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
        struct Wrapper: Codable, Equatable {
            let icon: WeatherIcon
        }

        try WeatherIcon.allCases.forEach { icon in
            let wrap = Wrapper(icon: icon)
            let data = try encoder.encode(wrap)
            let loaded = try decoder.decode(Wrapper.self, from: data)

            XCTAssertEqual(wrap, loaded)
        }
    }

    func testLanguageCodable() throws {
        struct Wrapper: Codable, Equatable {
            let lang: Language
        }

        try Language.allCases.forEach { lang in
            let wrap = Wrapper(lang: lang)
            let data = try encoder.encode(wrap)
            let loaded = try decoder.decode(Wrapper.self, from: data)

            XCTAssertEqual(wrap, loaded)
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
        XCTAssertEqual(current.wind, loaded.wind)
        XCTAssertEqual(current.precipitation, loaded.precipitation)
    }

    func testDailyDatapointCodable() throws {
        let datapoint = DailyDatapoint(apparentTemperatureHigh: 10.91, apparentTemperatureHighTime: Date(), apparentTemperatureLow: 10.9123, apparentTemperatureLowTime: Date(), apparentTemperatureMax: 10.00, apparentTemperatureMaxTime: Date(), apparentTemperatureMin: 12.1231, apparentTemperatureMinTime: Date(), moonPhase: 202.2, sunriseTime: Date(), sunsetTime: Date(), temperatureHigh: 202.2, temperatureHighTime: Date(), temperatureLow: 202.2, temperatureLowTime: Date(), temperatureMax: 2.2, temperatureMaxTime: Date(), temperatureMin: 2.2, temperatureMinTime: Date(), uvIndexTime: 202.2, cloudCover: 202.2, dewPoint: 202.2, humidity: 202.2, icon: .partlyCloudyDay, ozone: 202.2, pressure: 202.2, summary: "Generic summary", time: Date(), uvIndex: 8, visibility: 12.2, windSpeed: 2.2, windGust: 2.2, windBearing: 356, windGustTime: nil, precipIntensity: 2.2, precipIntensityError: 202.2, precipProbability: 12.2, precipType: .snow, precipIntensityMax: nil, precipIntensityMaxTime: nil, precipAccumulation: 12.2)

        let data = try encoder.encode(datapoint)
        let loaded = try decoder.decode(DailyDatapoint.self, from: data)
        XCTAssertEqual(datapoint, loaded)
        XCTAssertEqual(datapoint.wind, loaded.wind)
        XCTAssertEqual(datapoint.precipitation, loaded.precipitation)
    }

    func testMinutelyForecast() throws {
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

        let data = try encoder.encode(forecast)
        let loaded = try decoder.decode(Forecast<MinutelyDatapoint>.self, from: data)
        XCTAssertEqual(forecast, loaded)
        XCTAssertEqual(forecast.data.first?.precipitation, loaded.data.first?.precipitation)
    }

    func testDailyForecast() throws {
        let datapoints = [
            DailyDatapoint(apparentTemperatureHigh: 10, apparentTemperatureHighTime: Date(), apparentTemperatureLow: 10, apparentTemperatureLowTime: Date(), apparentTemperatureMax: 10.00, apparentTemperatureMaxTime: Date(), apparentTemperatureMin: 120312.1231, apparentTemperatureMinTime: Date(), moonPhase: 202.2, sunriseTime: Date(), sunsetTime: Date(), temperatureHigh: 202.2, temperatureHighTime: Date(), temperatureLow: 202.2, temperatureLowTime: Date(), temperatureMax: 202.2, temperatureMaxTime: Date(), temperatureMin: 202.2, temperatureMinTime: Date(), uvIndexTime: 202.2, cloudCover: 202.2, dewPoint: 202.2, humidity: 202.2, icon: .partlyCloudyDay, ozone: 202.2, pressure: 202.2, summary: "Generic summary", time: Date(), uvIndex: 10, visibility: 102312.2, windSpeed: 202.2, windGust: 202.2, windBearing: 356, windGustTime: nil, precipIntensity: 102312.2, precipIntensityError: 202.2, precipProbability: 102312.2, precipType: .snow, precipIntensityMax: nil, precipIntensityMaxTime: nil, precipAccumulation: 102312.2)
        ]

        let forecast = Forecast<DailyDatapoint>(summary: "asdasldas", icon: .cloudy, data: datapoints)

        let data = try encoder.encode(forecast)
        let loaded = try decoder.decode(Forecast<DailyDatapoint>.self, from: data)
        XCTAssertEqual(forecast, loaded)
    }

    func testHourlyForecast() throws {
        let datapoint = HourlyDatapoint(apparentTemperature: 100, temperature: 1231, cloudCover: 12312.01, dewPoint: 102, humidity: 1203, icon: WeatherIcon.clearNight, ozone: 12, pressure: 2133, summary: "askdas", time: Date(), uvIndex: 1, visibility: 1320.2312, windSpeed: 2903, windGust: 021, windBearing: nil, windGustTime: nil, precipIntensity: 123, precipIntensityError: 2131.124102, precipProbability: 024.021, precipType: PrecipitationType.sleet, precipIntensityMax: 123, precipIntensityMaxTime: nil, precipAccumulation: nil)

        let forecast = Forecast<HourlyDatapoint>(summary: "asdasldas", icon: .cloudy, data: [datapoint])

        let data = try encoder.encode(forecast)
        let loaded = try decoder.decode(Forecast<HourlyDatapoint>.self, from: data)
        XCTAssertEqual(forecast, loaded)
        XCTAssertEqual(forecast.data.first?.wind, loaded.data.first?.wind)
        XCTAssertEqual(forecast.data.first?.precipitation, loaded.data.first?.precipitation)
    }

    func testFlags() throws {
        let flags = Flags(units: .metric, sources: [], nearestStation: 123.123)

        let data = try encoder.encode(flags)
        let loaded = try decoder.decode(Flags.self, from: data)

        XCTAssertEqual(flags, loaded)
    }

    func testResponse() {
        let request = makeRequestObject()
        let exp = expectation(description: "fetched current data from server")

        HPDarkSky.shared.performRequest(request) { (forecast, error) in
            guard let forecast = forecast else {
                XCTAssertNil(error, "Error was not nil, description: \(error!.localizedDescription)")
                XCTFail("No forecast returned")
                exp.fulfill()
                return
            }
            exp.fulfill()

            do {
                let data = try self.encoder.encode(forecast)
                let loaded = try self.decoder.decode(DarkSkyResponse.self, from: data)

                XCTAssertEqual(forecast.currently, loaded.currently)
                XCTAssertEqual(forecast.flags, loaded.flags)
                XCTAssertEqual(forecast.hourly, loaded.hourly)
                XCTAssertEqual(forecast.daily, loaded.daily)
                XCTAssertEqual(forecast.alerts, loaded.alerts)
            } catch let error {
                XCTFail(error.localizedDescription)
            }
        }

        waitForExpectations(timeout: 20, handler: nil)
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
        ("testDailyForecast", testDailyForecast),
        ("testHourlyForecast", testHourlyForecast)
    ]
}
