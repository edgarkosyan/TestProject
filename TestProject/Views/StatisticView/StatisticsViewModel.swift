//
//  StatisticsViewModel.swift
//  TestProject
//
//  Created by Edgar on 09.08.22.
//

import Foundation

class StatisticsViewModel: ObservableObject {
    
    @Published var pills: [Pill] = []
    
    private let storage: Storage
    private let notificationManager: NotificationManager
    private let day = 60 * 60 * 24
    init(storage: Storage, manager: NotificationManager) {
        self.storage = storage
        self.notificationManager = manager
        refreshData()
        if !pills.isEmpty {
            notificationManager.blabla(pill: pills.first!)
        }
    }
    
    func refreshData() {
        pills = storage.getPills()
    }
    
}
