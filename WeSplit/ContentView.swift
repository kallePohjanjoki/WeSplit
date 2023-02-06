//
//  ContentView.swift
//  WeSplit
//
//  Created by Kalle Pohjanjoki on 2.2.2023.
//

import SwiftUI

struct ContentView: View {
	
	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocused: Bool
	
	
	
	let tipPercentageOptions: Array<Int> = [10, 15, 20, 25, 0]
	
	
	var totalPerPerson: Double {
		let peopleCount = Double (numberOfPeople + 2)
		let tipSelection = Double(tipPercentage)
		
		let totalTip = checkAmount / 100 * tipSelection
		
		let grandTotal = (checkAmount + totalTip) / peopleCount
		return grandTotal
	}
	
	var body: some View {
		NavigationView {
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
				
				Section {
					
					Picker("Tip percentage", selection: $tipPercentage) {
						ForEach(tipPercentageOptions, id: \.self) {
							Text($0, format: .percent)
						}
					}
					.pickerStyle(.segmented)
				} header: {
					Text("How much tip to give?")
				}
				
				Section {
					Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
					
				} header: {
					Text("Total amount per person")
				}
			}
			.navigationTitle("WeSplit")
			.toolbar {
				ToolbarItemGroup(placement: .keyboard) {
					Spacer()
					
					Button("Done") {
						amountIsFocused = false
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





