# HPDarkSky

[![Build Status](https://app.bitrise.io/app/3d3e9cae671ba5f6/status.svg?token=1SVKd2hSxM3GGwje1seumg&branch=master)](https://app.bitrise.io/app/3d3e9cae671ba5f6)
[![codebeat badge](https://codebeat.co/badges/f91a08f5-38ec-4d14-b25e-df2d380be4a4)](https://codebeat.co/projects/github-com-henrik-dmg-hpdarksky-master)
[![Swift Version](https://img.shields.io/badge/Swift-5.1-orange)](https://img.shields.io/badge/Swift-5.1-orange)
[![codecov](https://codecov.io/gh/henrik-dmg/HPDarkSky/branch/master/graph/badge.svg)](https://codecov.io/gh/henrik-dmg/HPDarkSky)
[![Documentation Coverage](https://hpdarksky.panhans.dev/badge.svg)](https://hpdarksky.panhans.dev)

HPDarkSky is a cross-platform Swift framework to fetch weather data from Dark Sky's JSON API. See their [documentation](https://darksky.net/dev) for further details.

## Installation

To install HPDarkSky, either add the URL of this repository directly to your Xcode project by clicking "File" -> "Swift Packages" -> "Add Package Dependency" or if you prefer the installation via CocoaPods, simply add `pod HPDarkSky` to your `Podfile`

|Deployment target   | OS Version  |
|--------------------|:------------|
| iOS                |     9.0+    |
| watchOS            |     3.0+    |
| macOS              |     10.13+  |
| tvOS                | 9.0+ |

## Usage
### Basics
To get started, you need an API key from Dark Sky ([register here](https://darksky.net/dev/register)). Then set your API key like this:
```swift
import HPDarkSky

// Use singleton
HPDarkSky.shared.secret = "YOUR_APIKEY"
// Or custom init
let api = HPDarkSky(secret: "YOUR_APIKEY", language: ..., units: ...)
```
For a list of supported languages see [Dark Sky's website](https://darksky.net/dev/docs)

### Making a request
```swift
let location = CLLocationCoordinate2D(latitude: 12.231, longitude: 69.420)
HPDarkSky.shared.requestWeather(forLocation: location, exlcudedFields: [.hourly]) { response, error in
	// Evaluate result here
}
```
**Note:** HPDarkSky automatically validates passed in locations (since you can initialize `CLLocationCoordinate2D` with any `Double` value) to stop you from making a request that will return an error anyways.

### Standalone request object
You may also initialise a standalone request object to use with your custom `URLSession` like this:
```swift
let location = CLLocationCoordinate2D(latitude: 12.231, longitude: 69.420)
let request = DarkSkyRequest(secret: "YOUR_APIKEY", location: location)

// URLSession extension included
URLSession.shared.dataTask(with: request) { data, response, error in
	// Do your thing here
}
```

### Excludable Fields
`ExcludableFields` is an enum that you can pass to either the API or a request object to tell the API that the fields in the array should be omitted from the response. You can use this to reduce used bandwidth for example or in cases where you're only interested in certain data and not the whole set.

### Time Machine

You may also pass an optional `Date` object to the API or a request object, which will return data from that point in time in the past (starting midnight 1970 UTC, you know the drill) or future.

**Note:** The timezone is only used for determining the time of the request; the response will always be relative to the local time zone.



## TODO

[x] Finish API interface

[X] Add unit tests

[ ] Reach 100% test coverage

[ ] Add conversion methods to convert between units



Henrik Panhans 2019, you can find me on [Twitter](https//twitter.com/henrik_dmg)