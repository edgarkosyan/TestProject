//
//  PillItemView.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import SwiftUI

struct PillItemView: View {
    var pill: Pill
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text("\(pill.name)")
                    .padding(.top, 3)
                    .font(.callout)
                    .lineLimit(1)
                    .minimumScaleFactor(0.6)
                Spacer()
            }
            HStack {
                HStack {
                    infoView(name: "Time", data: "\(pill.hour.format()) : \(pill.minute.format())")
                    infoView(name: "Dose", data: "\(String(format: "%.1f", pill.dose)) pill")
                }
                Spacer()
                LazyVGrid(columns: Array.init(repeating: GridItem(spacing: 10), count: 4), spacing: 5) {
                    ForEach(pill.days, id: \.self) { day in
                        Text(day.rawValue.prefix(3))
                            .font(.caption)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(4)
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
                            .frame(width: 45)
                    }
                }
            }
        }
        .frame(height: 100)
    }
    
    func infoView(name: String, data: String) -> some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.caption2)
                .foregroundColor(.secondary)
            Text(data)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal, 5)
                .padding(.vertical, 3)
                .background(Color.white)
                .cornerRadius(3)
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 2, y: 2)
        }
    }
}
//
//struct PillItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        PillItemView()
//    }
//}
