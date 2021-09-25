//
//  ContentView.swift
//  UniVert
//
//  Created by Octavius Bowman on 9/20/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputValue = 0
    @State private var outputValue = 0
    @State private var unitValue = ""
    
    
    let unitType = [UnitLength.millimeters,
                    UnitLength.centimeters,
                    UnitLength.inches,
                    UnitLength.feet,
                    UnitLength.yards,
                    UnitLength.meters,
                    UnitLength.kilometers,
                    UnitLength.miles]
    
    var converter: Measurement<UnitLength> {
        let inputAmount = Measurement(value: Double(unitValue) ?? 0, unit: unitType[inputValue])
        let outputAmount = inputAmount.converted(to: unitType[outputValue])
        return outputAmount
    }
    
    var formatter: MeasurementFormatter {
        let newFormat = MeasurementFormatter()
        newFormat.unitStyle = .long
        newFormat.unitOptions = .providedUnit
        return newFormat
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("\(formatter.string(from:unitType[inputValue]))", text: $unitValue).keyboardType(.decimalPad)
                    
                    Picker("Input Unit", selection: $inputValue) {
                        ForEach(0..<unitType.count) {
                            let formattedOutput = formatter.string(from: unitType[$0])
                            Text("\(formattedOutput)")
                        }
                    }
                    Picker("Output Unit", selection: $outputValue) {
                        ForEach(0..<unitType.count) {
                            let formattedOutput = formatter.string(from: unitType[$0])
                            Text("\(formattedOutput)")
                        }
                    }
                }
                Section(header: Text("Conversion")) {
                    Text(formatter.string(from: converter))
                }
            }.navigationBarTitle("UniVert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
