//
//  RootViewModel.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import Foundation

class RootViewModel: ObservableObject {
    @Published var currentPage: Pages = .mainView
    @Published var shouldShouTabbar: Bool = true
    private let storage: Storage
    private let notificationManager: NotificationManager
    
    init(storage: Storage = Storage(), manager: NotificationManager = NotificationManager()) {
        self.storage = storage
        self.notificationManager = manager
    }
    
    func buildMainViewModel() -> MainViewModel {
        let router = MainViewRouter { [weak self] in
            self?.shouldShouTabbar = false
            self?.currentPage = .addingView(pill: nil)
        } onPillViewTap: { [weak self] pill in
            self?.shouldShouTabbar = false
            self?.currentPage = .addingView(pill: pill)
        }
        return MainViewModel(router: router, storage: storage, manager: notificationManager)
    }
    
    func buildAddingViewModel(pill: Pill?) -> AddingViewModel {
        let router = AddingViewRouter { [weak self] in
            self?.shouldShouTabbar = true
            self?.currentPage = .mainView
        } onBack: { [weak self] in
            self?.shouldShouTabbar = true
            self?.currentPage = .mainView
        }
        return AddingViewModel(router: router, storage: storage, pill: pill, manager: notificationManager)
    }
    
    func buildStatisticsViewModel() -> StatisticsViewModel {
        return StatisticsViewModel(storage: storage, manager: notificationManager)
    }
}
enum Pages: Equatable {
    static func == (lhs: Pages, rhs: Pages) -> Bool {
        true
    }
    
    case mainView
    case addingView(pill: Pill?)
    case staticsView
}
