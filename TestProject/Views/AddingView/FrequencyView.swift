//
//  FrequencyView.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import SwiftUI

struct FrequencyView: View {
    @Binding var selectedFrequency: AddingViewModel.Frequency
    @Namespace var animation
    var body: some View {
        HStack {
            ForEach(AddingViewModel.Frequency.allCases, id: \.self) { frequency in
                ZStack {
                    if selectedFrequency == frequency {
                        Rectangle()
                        .frame(height: 50)
                        .foregroundColor(Color.white)
                        .cornerRadius(7)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
                        .matchedGeometryEffect(id: "freq", in: animation)
                    }
                    HStack {
                        Spacer()
                        Text(frequency.rawValue)
                        Spacer()
                    }
                    .frame(height: 50)
                    .cornerRadius(7)
                }
                .onTapGesture {
                    hideKeyboard()
                    withAnimation(.easeOut) {
                        selectedFrequency = frequency
                    }
                }
            }
        }
        .background(Color.gray.opacity(0.1))
    }
}

struct FrequencyView_Previews: PreviewProvider {
    static var previews: some View {
        FrequencyView(selectedFrequency: .constant(.everyDay))
    }
}
