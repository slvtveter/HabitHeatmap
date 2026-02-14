//
//  HabitViewModel.swift
//  HabitHeatmap
//
//  Created by Ilya Sergeev on 14.02.26.
//
import Foundation
import SwiftUI
internal import Combine

class HabitViewModel: ObservableObject {
    @Published var habit: Habit {
        didSet {
            
        }
    }
    private let key = "aa)"
    
    var isCompletedToday: Bool {
        habit.completedDates.contains { date in
            Calendar.current.isDate(date, inSameDayAs: Date())
        }
    }
    init(){
        
        if let data = UserDefaults.standard.data(forKey: key),
            let decodedHabit = try? JSONDecoder().decode(Habit.self, from: data) {
                self.habit = decodedHabit
        } else {
            self.habit = Habit(name: "First", completedDates: [])
        }
    }
    private func saveData() {
        if let encoded = try? JSONEncoder().encode(habit) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    func markDone(on date: Date) {
        if !isCompletedToday {
            habit.completedDates.append(date)
        }
        
    }
    func remark() {
        let today = Date()
        habit.completedDates.removeAll { date in
            Calendar.current.isDate(date, inSameDayAs: today)
        }
        
    }
    func lastDays(_ count: Int) -> [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<count).compactMap { day in
            calendar.date(byAdding: .day, value: -day, to: today)
        }.reversed()
    }
}
