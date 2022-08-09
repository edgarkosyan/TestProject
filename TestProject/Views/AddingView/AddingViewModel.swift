//
//  AddingViewModel.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import Foundation

struct AddingViewRouter {
    var save: () -> ()
    var onBack: () -> ()
}

class AddingViewModel: ObservableObject {
    enum Frequency: String, CaseIterable {
        case everyDay = "Every Day"
        case specificDays = "Specific Days"
    }
    enum WeekDays: String, CaseIterable, Codable {
        case sunday = "Sunday"
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
    }
    
    @Published var title: String = ""
    @Published var medicationName: String = ""
    @Published var selectedFrequency: Frequency = .everyDay
    @Published var hour: Int = 0
    @Published var minute: Int = 0
    @Published var pillDose: Double = 1
    @Published var selectedDays: [WeekDays] = []
    
    private let pill: Pill?
    private let router: AddingViewRouter
    private let storage: Storage
    private let notificationManager: NotificationManager
    
    init(router: AddingViewRouter, storage: Storage, pill: Pill? = nil, manager: NotificationManager) {
        self.router = router
        self.storage = storage
        self.pill = pill
        self.notificationManager = manager
        setUpData(pill: pill)
        setUpTitle()
    }
    
    func onBack() {
        router.onBack()
    }
    
    func save() {
        var newPill = Pill(name: medicationName, dose: pillDose, hour: hour, minute: minute, days: selectedDays)
        if let pill = pill {
            newPill.id = pill.id
            storage.updatePill(pill: newPill)
            notificationManager.removeNotification(pill: newPill)
        } else {
            storage.addPill(pill: newPill)
        }
        notificationManager.scheduleNotification(pill: newPill)
        router.save()
    }
    
    private func setUpTitle() {
        title = pill == nil ? "Add Medicine" : "Update medicine"
    }
    
    private func setUpData(pill: Pill?) {
        if let pill = pill {
            self.hour = pill.hour
            self.minute = pill.minute
            self.medicationName = pill.name
            self.pillDose = pill.dose
            self.selectedDays = pill.days
        } else {
            for day in WeekDays.allCases {
                selectedDays.append(day)
            }
        }
    }
}

