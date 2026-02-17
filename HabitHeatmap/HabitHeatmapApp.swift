//
//  HabitHeatmapApp.swift
//  HabitHeatmap
//
//  Created by Ilya Sergeev on 14.02.26.
//

import SwiftUI

@main
struct HabitHeatmapApp: App {
    var body: some Scene {
        WindowGroup {
           // ContentView()
            HabitDetailView(viewModel: HabitViewModel(), habit: Habit(name: "a", completedDates: []))
        }
    }
}
