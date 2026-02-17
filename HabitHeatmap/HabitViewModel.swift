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
    @Published var habits: [Habit] = [Habit(name: "Sport", completedDates: [Date()]), Habit(name: "lessons", completedDates: [])] {
        didSet {
            saveData()
        }
    }
    private let key = "aa)"
   
    init(){
        
        if let data = UserDefaults.standard.data(forKey: key),
            let decodedHabit = try? JSONDecoder().decode([Habit].self, from: data) {
                self.habits = decodedHabit
        } else {
            self.habits = []
        }
    }
    
    func addHabit(name: String) {
        let newHabit = Habit(name: name, completedDates: [])
        habits.append(newHabit)
    }
    
    func deleteHabit(at offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    func toggleCompletion(for habitID: UUID, date: Date) {
        if let index = habits.firstIndex(where: { $0.id == habitID }) {
            let isDone = habits[index].completedDates.contains { Calendar.current.isDate(date, inSameDayAs: $0) }
            if isDone {
                habits[index].completedDates.removeAll {Calendar.current.isDate($0, inSameDayAs: date)}
            } else {
                habits[index].completedDates.append(date)
            }
        }
    }
    
    private func saveData() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
   
        
    func totalCompleted(for date: Date) -> Int {
        habits.filter { habit in
            habit.completedDates.contains { Calendar.current.isDate($0, inSameDayAs: date)}
        }.count
    }
    
    func colorFor(date: Date) -> Color {
        let count = totalCompleted(for: date)
        if count == 0 { return Color.gray.opacity(0.2) }
        
        switch count {
        case 1: return Color.green.opacity(0.3)
        case 2: return Color.green.opacity(0.4)
        case 3: return Color.green.opacity(0.6)
        case 4: return Color.green.opacity(0.7)
        case 5: return Color.green.opacity(0.8)
        case 6: return Color.green.opacity(0.9)
        default:
            return Color.green.opacity(0.95)
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
