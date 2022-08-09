//
//  StatisticView.swift
//  TestProject
//
//  Created by Edgar on 09.08.22.
//

import SwiftUI

struct StatisticsView: View {
    @ObservedObject var viewModel: StatisticsViewModel
    var body: some View {
        VStack {
            HStack {
                Text("Statistics")
                    .font(.title)
                    .fontWeight(.medium)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, UIDevice.safeAreaTop())
            .padding(.top, 10)
            if viewModel.pills.isEmpty {
                Text("No Data!")
                    .font(.title)
                    .foregroundColor(.secondary)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(viewModel.pills) { pill in
                            HStack {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(pill.name)
                                        .font(.title2)
                                    HStack {
                                        Text("Medication count:")
                                        Text("0")
                                    }
                                    .font(.caption)
                                    .foregroundColor(.primary)
                                    
                                }
                                .padding()
                                Spacer()
                            }
                            .background(Color.white)
                            .shadow(color: .gray.opacity(0.3), radius: 4, x: 4, y: 4)
                        }
                    }
                    .padding()
                }
            }
            Spacer()
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView(viewModel: StatisticsViewModel(storage: Storage(), manager: NotificationManager()))
    }
}
