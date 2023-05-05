//
//  ContentView.swift
//  ConversionApp
//
//  Created by Josua Hutapea on 30/04/23.
//

import SwiftUI

struct ContentView: View {
    private static let temperatures = [
        UnitTemperature.celsius,
        .fahrenheit,
        .kelvin
    ]

    private static let lengths = [
        UnitLength.meters,
        .kilometers,
        .feet,
        .yards,
        .miles
    ]

    private static let times = [
        UnitDuration.seconds,
        .minutes,
        .hours,
    ]

    private static let volume = [
        UnitVolume.milliliters,
        .liters,
        .cups,
        .pints,
        .gallons
    ]

    private static let dimensions: [[Dimension]] = [
        temperatures,
        lengths,
        times,
        volume
    ]

    private static let dimensionsName: [String] = [
        "Temperature",
        "Length",
        "Time",
        "Volume"
    ]

    @FocusState private var inputIsFocused: Bool
    @State var selectedDimensionIndex = 0
    @State var inputUnitIndex = 0
    @State var outputUnitIndex = 0
    @State var input: Double = 0

    private var units: [Dimension] {
        ContentView.dimensions[selectedDimensionIndex]
    }

    var output: Double {
        let inputUnit = units[inputUnitIndex]
        let outputUnit = units[outputUnitIndex]
                let original = Measurement(value: input, unit: inputUnit)
                let converted = original.converted(to: outputUnit)
                return converted.value
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select quantity", selection: $selectedDimensionIndex) {
                        ForEach(0 ..< ContentView.dimensions.count, id: \.self) { index in
                            Text(ContentView.dimensionsName[index])
                        }
                    }
                }

                Section {
                    TextField("Input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)

                    Picker("Input Unit", selection: $inputUnitIndex) {
                        ForEach(0 ..< units.count, id: \.self) { index in
                            Text(units[index].symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("From")
                }

                Section {
                    Text(String(format: "%.2f", output))

                    Picker("Output Unit", selection: $outputUnitIndex) {
                        ForEach(0 ..< units.count, id: \.self) { index in
                            Text(units[index].symbol)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("To")
                }
            }
            .navigationTitle("Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




