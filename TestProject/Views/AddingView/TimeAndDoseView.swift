//
//  TimeAndDoseView.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import SwiftUI

struct TimeAndDoseView: View {
    @Binding var pillDose: Double
    var hour: () -> (Int)
    var minute: () -> (Int)
    var onTimeTap: () -> ()
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Set Time")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Button {
                    onTimeTap()
                    hideKeyboard()
                } label: {
                    Text("\(hour().format()) : \(minute().format())")
                        .padding()
                        .padding(.horizontal)
                        .foregroundColor(.primary)
                        .frame(width: 120, height: 50)
                        .background(Color.white)
                        .cornerRadius(7)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
                }
            }
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                Text("Set Dose")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack {
                    Button {
                        pillDose -= 0.5
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.caption)
                        }
                        .padding(.horizontal)
                        .frame(height: 50)
                        .background(pillDose == 0.5 ? Color.gray.opacity(0.1): Color.white)
                        .cornerRadius(7)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
                        
                    }
                    .disabled(pillDose == 0.5)
                    Button {
                        pillDose += 0.5
                    } label: {
                        HStack {
                            Image(systemName: "chevron.right")
                                .font(.caption)
                        }
                        .padding(.horizontal)
                        .frame(height: 50)
                        .background(pillDose == 9 ? Color.gray.opacity(0.1): Color.white)
                        .cornerRadius(7)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
                    }
                    .disabled(pillDose == 9)
                    Text(String(format: "%.1f", pillDose))
                        .padding(.leading)
                        .font(.title3)
                        .frame(width: 50)
                }
            }
            Spacer()
            
        }
    }
}

struct TimeAndDoseView_Previews: PreviewProvider {
    static var previews: some View {
        TimeAndDoseView(pillDose: .constant(3)) {
            2
        } minute: {
            2
        } onTimeTap: {
            
        }
        
    }
}
