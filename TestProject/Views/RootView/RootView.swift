//
//  RootView.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import SwiftUI

struct RootView: View {
    @ObservedObject var viewModel: RootViewModel
    var body: some View {
        VStack {
            switch viewModel.currentPage {
            case .mainView:
                MainView(viewModel: viewModel.buildMainViewModel())
            case .addingView(let pill):
                AddingView(viewModel: viewModel.buildAddingViewModel(pill: pill))
            case .staticsView:
                StatisticsView(viewModel: viewModel.buildStatisticsViewModel())
            }
            if viewModel.shouldShouTabbar {
                TabView(selectedPage: $viewModel.currentPage)
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(viewModel: RootViewModel())
    }
}
