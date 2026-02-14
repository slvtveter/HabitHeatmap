//
//  Habit.swift
//  HabitHeatmap
//
//  Created by Ilya Sergeev on 14.02.26.
//
import Foundation

struct Habit: Codable, Identifiable {
    var id = UUID()
    var name: String
    var completedDates: [Date]
}
