//
//  ContentView.swift
//  UnitConversion
//
//  Created by Gaurav Bisht on 03/09/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var fromUnitValue = AllUnit.none
    @State private var toUnitValue = AllUnit.none
    @State private var shouldDisableUnitToPicker = true
    @State private var valueToConvert: Double?
    @FocusState private var isValueFieldFocused: Bool
    
    private var allUnitsArray = AllUnit.allCases
    
    private let temperatureUnits: [String] = AllUnit.allCases
        .filter { $0 == .celsius || $0 == .fahrenheit || $0 == .kelvin }
        .map { $0.rawValue }
    
    private let lengthUnits: [String] = AllUnit.allCases
        .filter { $0 == .meter || $0 == .kilometer || $0 == .centimeter || $0 == .millimeter || $0 == .inch || $0 == .foot || $0 == .yard || $0 == .mile }
        .map { $0.rawValue }
    
    private let timeUnits: [String] = AllUnit.allCases
        .filter { $0 == .second || $0 == .minute || $0 == .hour || $0 == .day || $0 == .week || $0 == .month || $0 == .year }
        .map { $0.rawValue }
    
    private let volumeUnits: [String] = AllUnit.allCases
        .filter { $0 == .liter || $0 == .milliliter || $0 == .cubicMeter || $0 == .gallon || $0 == .quart || $0 == .pint || $0 == .cup || $0 == .fluidOunce || $0 == .tablespoon || $0 == .teaspoon }
        .map { $0.rawValue }
    
    private var filteredUnits: [AllUnit] {
        var unitsInStrings = [String]()
        
        if temperatureUnits.contains(fromUnitValue.rawValue) {
            unitsInStrings = temperatureUnits
        } else if lengthUnits.contains(fromUnitValue.rawValue) {
            unitsInStrings = lengthUnits
        } else if timeUnits.contains(fromUnitValue.rawValue) {
            unitsInStrings = timeUnits
        } else if volumeUnits.contains(fromUnitValue.rawValue) {
            unitsInStrings = volumeUnits
        }
        
        return allUnitsArray.filter { unitsInStrings.contains($0.rawValue) }
    }
    
    private var convertedValue: Double {
        return convertValue()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Convert unit from") {
                    Picker("Select Unit", selection: $fromUnitValue) {
                        ForEach(allUnitsArray, id: \.self) {
                            Text("\($0.rawValue)")
                        }
                    }
                    .onChange(of: fromUnitValue) { oldValue, newValue in
                        shouldDisableUnitToPicker = newValue == AllUnit.none
                    }
                    
                    TextField("Enter the value to be converted", value: $valueToConvert, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isValueFieldFocused)
                }
                
                if !shouldDisableUnitToPicker {
                    Section("Convert unit to") {
                        Picker("Select Unit", selection: $toUnitValue) {
                            ForEach(filteredUnits, id: \.self) {
                                Text("\($0.rawValue)")
                            }
                        }
                    }
                }
                
                if let _ = valueToConvert, !shouldDisableUnitToPicker {
                    Section {
                        Text(String(convertedValue))
                    }
                }
            }
            .navigationTitle("Unit Conversion")
            .toolbar {
                if isValueFieldFocused {
                    Button("Done") {
                        isValueFieldFocused = false
                    }
                }
            }
        }
    }
    
    private func convertValue() -> Double {
        guard let valueToConvert = valueToConvert else { return 0.0 }
        if fromUnitValue == .celsius ||
            fromUnitValue == .fahrenheit ||
            fromUnitValue == .kelvin {
            return fromUnitValue.convertTemperature(valueToConvert, to: toUnitValue)
        } else if fromUnitValue == .meter ||
                    fromUnitValue == .kilometer ||
                    fromUnitValue == .centimeter ||
                    fromUnitValue == .millimeter ||
                    fromUnitValue == .inch ||
                    fromUnitValue == .foot ||
                    fromUnitValue == .yard ||
                    fromUnitValue == .mile {
            return fromUnitValue.convertTemperature(valueToConvert, to: toUnitValue)
        } else if fromUnitValue == .second ||
                    fromUnitValue == .minute ||
                    fromUnitValue == .hour ||
                    fromUnitValue == .day ||
                    fromUnitValue == .week ||
                    fromUnitValue == .month ||
                    fromUnitValue == .year {
            return fromUnitValue.convertTime(valueToConvert, to: toUnitValue)
        } else if fromUnitValue == .liter ||
                    fromUnitValue == .milliliter ||
                    fromUnitValue == .cubicMeter ||
                    fromUnitValue == .gallon ||
                    fromUnitValue == .quart ||
                    fromUnitValue == .pint ||
                    fromUnitValue == .cup ||
                    fromUnitValue == .fluidOunce ||
                    fromUnitValue == .tablespoon ||
                    fromUnitValue == .teaspoon {
            return fromUnitValue.convertVolume(valueToConvert, to: toUnitValue)
        }
        return 0.0
    }
}

#Preview {
    ContentView()
}
