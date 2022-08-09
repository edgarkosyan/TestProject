//
//  TabView.swift
//  TestProject
//
//  Created by Edgar on 09.08.22.
//

import SwiftUI

struct TabView: View {
    @Binding var selectedPage: Pages
    var body: some View {
        HStack {
            HStack {
                Spacer()
                Image(systemName: "pills")
                    .foregroundColor(!isSelected() ? .gray : .black)
                Spacer()
            }
            .onTapGesture {
                selectedPage = .mainView
            }
            HStack {
                Spacer()
                Image(systemName: "chart.bar")
                    .foregroundColor(isSelected() ? .gray : .black)
                Spacer()
            }
            .onTapGesture {
                selectedPage = .staticsView
            }
        }
        .font(.title2)
        .padding(.vertical)
        .edgesIgnoringSafeArea(.all)
        .padding(.bottom, UIDevice.safeAreaBottom())
        .padding(.bottom, 10)
        .background(Color.white)
        .shadow(color: .gray.opacity(0.4), radius: 4, x: 2, y: 2)
    }
    
    func isSelected() -> Bool {
        switch selectedPage {
        case .mainView:
            return true
        case .addingView:
            return true
        case .staticsView:
            return false
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView(selectedPage: .constant(.staticsView))
    }
}
