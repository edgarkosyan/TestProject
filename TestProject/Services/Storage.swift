//
//  Storage.swift
//  TestProject
//
//  Created by Edgar on 08.08.22.
//

import Foundation

class Storage {
    
    struct C {
        static let kDATEKEY = "datekey"
        static let kPILLSDATA = "pillsdata"
    }
    
    private let userDefaults = UserDefaults.standard
    
    private var storeDate: Date? {
        didSet {
            userDefaults.set(Date(), forKey: C.kDATEKEY)
        }
    }
    
    private var pills: [Pill] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(pills) {
                userDefaults.set(encoded, forKey: C.kPILLSDATA)
            }
        }
    }
    
    init() {
        self.storeDate = userDefaults.object(forKey: C.kDATEKEY) as? Date ?? nil
        decodeData()
    }
    
    func getStoreDate() -> Date? {
        return storeDate
    }
    
    func setStoreDate() {
        storeDate = Date()
    }
    
    func deletePill(index: IndexSet) {
        pills.remove(atOffsets: index)
    }
    
    func addPill(pill: Pill) {
        pills.append(pill)
    }
    
    func getPills() -> [Pill] {
        pills
    }
    
    func updatePill(pill: Pill) {
        if let index = pills.firstIndex(where: {$0.id == pill.id}) {
            pills[index] = pill
        }
    }
    
    private func decodeData() {
        //DispatchQueue.global(qos: .background).async {
            if let data = self.userDefaults.data(forKey: C.kPILLSDATA) {
                if let decoded = try? JSONDecoder().decode([Pill].self, from: data) {
                    self.pills = decoded
                    return
                }
            }
       // }
    }
}

struct Pill: Identifiable, Codable {
    var id: String = UUID().uuidString
    var creationDate: Date = Date()
    var name: String
    var dose: Double
    var hour: Int
    var minute: Int
    var days: [AddingViewModel.WeekDays]
}

