//
//  HabitDetailView.swift
//  HabitHeatmap
//
//  Created by Ilya Sergeev on 15.02.26.
//

import SwiftUI

struct HabitDetailView: View {
    
    @ObservedObject var viewModel: HabitViewModel
    let columns = Array(repeating: GridItem(.fixed(30), spacing: 5), count: 7)
    var habit: Habit
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Streak: \(habit.completedDates.count)")
                
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.lastDays(28), id: \.self) { day in
                        Rectangle()
                            .fill(viewModel.colorFor(date: day))
                            .frame(width: 30, height: 30)
                            .cornerRadius(4)
                    }
                }
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(16)
                .padding()
            }
            .navigationTitle(habit.name)
        }
        Button(action: { viewModel.toggleCompletion(for: habit.id, date: Date()) }) {
            HStack {
                Image(systemName: "checkmark")
                    .foregroundStyle(.white)
                Text("Completed today")
                    .foregroundStyle(.white)
                    
            }
        }.background(Color.blue)
    }
}

#Preview {
    HabitDetailView(viewModel: HabitViewModel(), habit: Habit(name: "a", completedDates: []))
}
