//
//  SettingTimeView.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import SwiftUI

struct TimePickerView: View {
    @Binding var hours: Int
    @Binding var minutes: Int
    @State var isSelectedHour = true
    var body: some View {
        VStack {
            HStack {
                Rectangle()
                    .frame(width: 70, height: 5)
                    .foregroundColor(.black.opacity(0.9))
                    .cornerRadius(7)
            }
            .padding()
            HStack {
                
                HStack {
                    Spacer()
                    Text("Hour")
                    Spacer()
                }
                .frame(height: 40)
                .background(isSelectedHour ? Color.white : Color.gray.opacity(0.1))
                .cornerRadius(7)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
                .onTapGesture {
                    isSelectedHour = true
                }
                
                HStack {
                    Spacer()
                    Text("Minutes")
                    Spacer()
                }
                .frame(height: 40)
                .background(!isSelectedHour ? Color.white : Color.gray.opacity(0.1))
                .cornerRadius(7)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
                .onTapGesture {
                    isSelectedHour = false
                }
            }
            .font(.callout)
            .foregroundColor(.black)
            
            if isSelectedHour {
                Picker("", selection: $hours){
                    ForEach(0..<24, id: \.self) { i in
                        Text("\(i) hours").tag(i)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            } else {
                Picker("", selection: $minutes){
                    ForEach(0..<60, id: \.self) { i in
                        Text("\(i) min").tag(i)
                    }
                }
                .pickerStyle(WheelPickerStyle())
            }
            
            
        }
        .background(Color.white)
        .cornerRadius(7, corners: [.topLeft, .topRight])
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView(hours: .constant(3), minutes: .constant(2))
    }
}
