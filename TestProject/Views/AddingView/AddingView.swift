//
//  AddingView.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import SwiftUI

struct AddingView: View {
    @ObservedObject var viewModel: AddingViewModel
    @State var shouldShowPickerView: Bool = false
    @State var offsetY: Double = .zero
    @State var shouldDimBackScreen: Bool = false
    @Namespace var nameSpace
    var body: some View {
        ZStack {
            VStack {
                addViewNavigation()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        VStack(alignment: .leading, spacing: 25) {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Med Info")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                
                                TextField("Medication Name", text: $viewModel.medicationName)
                                    .padding()
                                    .foregroundColor(.primary)
                                    .background(Color.secondary.opacity(0.1))
                                    .cornerRadius(7)
                            }
                            .padding(.top)
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Frequency")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                FrequencyView(selectedFrequency: $viewModel.selectedFrequency)
                            }
                            .padding(.top)
                            TimeAndDoseView(pillDose: $viewModel.pillDose) {
                                viewModel.hour
                            } minute: {
                                viewModel.minute
                            } onTimeTap: {
                                withAnimation {
                                    shouldDimBackScreen = true
                                    shouldShowPickerView = true
                                }
                            }
                        }
                        .padding(20)
                        if viewModel.selectedFrequency == .specificDays {
                            VStack(spacing: 10) {
                                ForEach(AddingViewModel.WeekDays.allCases, id: \.self) { day in
                                    HStack {
                                        Text(day.rawValue)
                                            .font(.callout)
                                        Spacer()
                                        Circle()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(viewModel.selectedDays.contains(where: {$0 == day}) ? .green : .gray)
                                        
                                    }
                                    .padding(.horizontal)
                                    .frame(height: 50)
                                    .background(Color.white)
                                    .cornerRadius(7)
                                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
                                    .padding(.horizontal, 20)
                                    .onTapGesture {
                                        if viewModel.selectedDays.contains(where: {$0 == day}) {
                                            viewModel.selectedDays.removeAll(where: {$0 == day})
                                        } else {
                                            viewModel.selectedDays.append(day)
                                        }
                                        
                                    }
                                }
                            }
                            .padding(.bottom, 20)
                        }
                        Spacer()
                    }
                }
            }
            if shouldDimBackScreen {
                Color.black.opacity(0.3)
            }
            if shouldShowPickerView {
                VStack {
                    Spacer()
                    TimePickerView(hours: $viewModel.hour, minutes: $viewModel.minute)
                        .offset(y: offsetY)
                        .gesture(DragGesture().onChanged({(value) in
                            withAnimation {
                                if value.translation.height > 0 {
                                    offsetY = value.translation.height
                                }
                            }
                        }).onEnded({(value) in
                            if value.translation.height > 70 {
                                withAnimation {
                                    shouldShowPickerView = false
                                    offsetY = .zero
                                }
                                shouldDimBackScreen = false
                            } else {
                                withAnimation {
                                    offsetY = .zero
                                }
                            }
                        }))
                }
                .transition(.move(edge: .bottom))
            }
        }
        .ignoresSafeArea(.all, edges: .all)
        .onTapGesture(perform: {
            hideKeyboard()
        })
    }
    
    func addViewNavigation() -> some View {
        HStack {
            Button {
                hideKeyboard()
                viewModel.onBack()
            } label: {
                Text("Cancel")
                    .font(.callout)
                    .foregroundColor(.blue)
            }
            Spacer()
            Text(viewModel.title)
                .font(.title2)
                .foregroundColor(.primary)
            Spacer()
            Button {
                hideKeyboard()
                viewModel.save()
            } label: {
                Text("Save")
                    .font(.callout)
                    .foregroundColor(viewModel.medicationName.isEmpty ? .secondary : .blue)
            }
            .disabled(viewModel.medicationName.isEmpty)
        }
        .padding(.horizontal)
        .padding(.top, UIDevice.safeAreaTop())
        .padding(.top, 10)
    }
}

struct AddingView_Previews: PreviewProvider {
    static var previews: some View {
        AddingView(viewModel: AddingViewModel(router: AddingViewRouter(save: {
            
        }, onBack: {
            
        }), storage: Storage(), manager: NotificationManager()))
    }
}
