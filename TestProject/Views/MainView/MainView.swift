//
//  MainView.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var editMode = EditMode.inactive
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("Scedule")
                        .font(.title)
                        .fontWeight(.medium)
                    Text("your")
                        .font(.title3)
                        .fontWeight(.light)
                    Text("Pills")
                        .font(.title)
                        .fontWeight(.medium)
                }
                Spacer()
                Button {
                    viewModel.addPill()
                } label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(.primary)
                }
            }
            .padding()
            .padding(.top, UIDevice.safeAreaTop())
            .padding(.top, 10)
            List {
                itemsView()
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .padding(.top)
            }
            .listStyle(PlainListStyle())
            .padding(.top)
            .environment(\.editMode, $editMode)

        }
        .edgesIgnoringSafeArea(.all)
    }
    
    func itemsView() -> some View {
        ForEach(viewModel.pills) { pill in
            PillItemView(pill: pill)
                .padding(.horizontal)
                .background(Color.white)
                .cornerRadius(7)
                .shadow(color: .gray.opacity(0.5), radius: 6, x: 2, y: 2)
                .padding(.horizontal)
                .onTapGesture {
                    viewModel.onPillViewTap(pill: pill)
                }
        }
        .onDelete { indexSet in
            viewModel.removePillFromList(indexSet)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(router: MainViewRouter(addPill: {
            
        }, onPillViewTap: { _ in
            
        }), storage: Storage(), manager: NotificationManager()))
    }
}
