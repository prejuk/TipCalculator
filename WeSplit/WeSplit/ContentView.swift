//
//  ContentView.swift
//  WeSplit
//
//  Created by Preju Kanuparthy on 12/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages: ClosedRange<Int> = 0...100
    
    var totalPerPerson: Double {
        let people = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
       
        let tipValue = ((checkAmount/100)*tipSelection)
        let grandTotal = checkAmount + tipValue
        let amountperPerson = grandTotal / people
        return amountperPerson
    }
    
    var totalChallenge: Double {
        _ = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
       
        let tipValue = ((checkAmount/100)*tipSelection)
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section("How much do you want to tip?") {
                    
                    
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    
                }
                Section("Total Amount"){
                    Text(totalChallenge, format:.currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount Per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
