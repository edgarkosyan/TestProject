//
//  MainViewModel.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import Foundation

struct MainViewRouter {
    var addPill: () -> ()
    var onPillViewTap: (Pill) -> ()
}

class MainViewModel: ObservableObject {

    @Published var pills: [Pill] = []
    
    private let router: MainViewRouter
    private let storage: Storage
    private let notificationManager: NotificationManager
    
    init(router: MainViewRouter, storage: Storage, manager: NotificationManager) {
        self.router = router
        self.storage = storage
        self.notificationManager = manager
        refreshData()
    }
    
    func removePillFromList(_ indexSet: IndexSet) {
        storage.deletePill(index: indexSet)
        removeNotification(indexSet: indexSet)
        refreshData()
    }
    
    func removeNotification(indexSet: IndexSet) {
        for index in indexSet {
            let pill = pills[index]
            notificationManager.removeNotification(pill: pill)
        }
    }
    
    func refreshData() {
        pills = storage.getPills()
    }
    
    func addPill() {
        router.addPill()
    }
    
    func onPillViewTap(pill: Pill) {
        router.onPillViewTap(pill)
    }
}


