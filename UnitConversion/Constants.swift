//
//  Constants.swift
//  UnitConversion
//
//  Created by Gaurav Bisht on 03/09/24.
//

import Foundation

enum AllUnit: String, CaseIterable {
    case none = "None"
    
    // Temperature Units
    case celsius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"
    
    // Length Units
    case meter = "Meter"
    case kilometer = "Kilometer"
    case centimeter = "Centimeter"
    case millimeter = "Millimeter"
    case inch = "Inch"
    case foot = "Foot"
    case yard = "Yard"
    case mile = "Mile"
    
    // Time Units
    case second = "Second"
    case minute = "Minute"
    case hour = "Hour"
    case day = "Day"
    case week = "Week"
    case month = "Month"
    case year = "Year"
    
    // Volume Units
    case liter = "Liter"
    case milliliter = "Milliliter"
    case cubicMeter = "Cubic Meter"
    case gallon = "Gallon"
    case quart = "Quart"
    case pint = "Pint"
    case cup = "Cup"
    case fluidOunce = "Fluid Ounce"
    case tablespoon = "Tablespoon"
    case teaspoon = "Teaspoon"
    
    // Convert temperature to Celsius
    private func toCelsius(_ value: Double) -> Double {
        switch self {
        case .celsius:
            return value
        case .fahrenheit:
            return (value - 32) * 5 / 9
        case .kelvin:
            return value - 273.15
        default:
            return 0.0
        }
    }

    // Convert temperature to Fahrenheit
    private func toFahrenheit(_ value: Double) -> Double {
        switch self {
        case .celsius:
            return (value * 9 / 5) + 32
        case .fahrenheit:
            return value
        case .kelvin:
            return (value - 273.15) * 9 / 5 + 32
        default:
            return 0.0
        }
    }

    // Convert temperature to Kelvin
    private func toKelvin(_ value: Double) -> Double {
        switch self {
        case .celsius:
            return value + 273.15
        case .fahrenheit:
            return (value - 32) * 5 / 9 + 273.15
        case .kelvin:
            return value
        default:
            return 0.0
        }
    }

    // Convert from one temperature unit to another
    func convertTemperature(_ value: Double, to targetUnit: AllUnit) -> Double {
        switch targetUnit {
        case .celsius:
            return self.toCelsius(value)
        case .fahrenheit:
            return self.toFahrenheit(value)
        case .kelvin:
            return self.toKelvin(value)
        default:
            return 0.0
        }
    }
    
    private func toMeters(_ value: Double) -> Double {
        switch self {
        case .meter:
            return value
        case .kilometer:
            return value * 1000
        case .centimeter:
            return value / 100
        case .millimeter:
            return value / 1000
        case .inch:
            return value * 0.0254
        case .foot:
            return value * 0.3048
        case .yard:
            return value * 0.9144
        case .mile:
            return value * 1609.34
        default:
            return 0.0
        }
    }

    private func fromMeters(_ value: Double) -> Double {
        switch self {
        case .meter:
            return value
        case .kilometer:
            return value / 1000
        case .centimeter:
            return value * 100
        case .millimeter:
            return value * 1000
        case .inch:
            return value / 0.0254
        case .foot:
            return value / 0.3048
        case .yard:
            return value / 0.9144
        case .mile:
            return value / 1609.34
        default:
            return 0.0
        }
    }

    func convertLength(_ value: Double, to targetUnit: AllUnit) -> Double {
        let valueInMeters = self.toMeters(value)
        return targetUnit.fromMeters(valueInMeters)
    }
    
    private func toSeconds(_ value: Double) -> Double {
        switch self {
        case .second:
            return value
        case .minute:
            return value * 60
        case .hour:
            return value * 3600
        case .day:
            return value * 86400
        case .week:
            return value * 604800
        case .month:
            return value * 2592000 // Approximate (30 days)
        case .year:
            return value * 31536000 // Approximate (365 days)
        default:
            return 0.0
        }
    }

    private func fromSeconds(_ value: Double) -> Double {
        switch self {
        case .second:
            return value
        case .minute:
            return value / 60
        case .hour:
            return value / 3600
        case .day:
            return value / 86400
        case .week:
            return value / 604800
        case .month:
            return value / 2592000 // Approximate (30 days)
        case .year:
            return value / 31536000 // Approximate (365 days)
        default:
            return 0.0
        }
    }

    func convertTime(_ value: Double, to targetUnit: AllUnit) -> Double {
        let valueInSeconds = self.toSeconds(value)
        return targetUnit.fromSeconds(valueInSeconds)
    }
    
    private func toLiters(_ value: Double) -> Double {
        switch self {
        case .liter:
            return value
        case .milliliter:
            return value / 1000
        case .cubicMeter:
            return value * 1000
        case .gallon:
            return value * 3.78541
        case .quart:
            return value * 0.946353
        case .pint:
            return value * 0.473176
        case .cup:
            return value * 0.24
        case .fluidOunce:
            return value * 0.0295735
        case .tablespoon:
            return value * 0.0147868
        case .teaspoon:
            return value * 0.00492892
        default:
            return 0.0
        }
    }

    private func fromLiters(_ value: Double) -> Double {
        switch self {
        case .liter:
            return value
        case .milliliter:
            return value * 1000
        case .cubicMeter:
            return value / 1000
        case .gallon:
            return value / 3.78541
        case .quart:
            return value / 0.946353
        case .pint:
            return value / 0.473176
        case .cup:
            return value / 0.24
        case .fluidOunce:
            return value / 0.0295735
        case .tablespoon:
            return value / 0.0147868
        case .teaspoon:
            return value / 0.00492892
        default:
            return 0.0
        }
    }

    func convertVolume(_ value: Double, to targetUnit: AllUnit) -> Double {
        let valueInLiters = self.toLiters(value)
        return targetUnit.fromLiters(valueInLiters)
    }
}
