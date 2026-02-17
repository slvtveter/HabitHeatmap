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
        
        VStack {
            
            VStack {
                Text(habit.name)
                    .foregroundStyle(.white)
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(16)
                Text("Streak: \(habit.completedDates.count)")
                    .font(.headline)
            }
            
            LazyVGrid(columns: columns) {
                ForEach(viewModel.lastDays(28), id: \.self) { day in
                    Rectangle()
                        .fill(habit.completedDates.contains {
                            Calendar.current.isDate($0, inSameDayAs: day)
                        } ? Color.green.opacity(0.7) : Color.gray.opacity(0.2))
                        .frame(width: 30, height: 30)
                        .cornerRadius(4)
                }
            }
            .padding()
            .background(Color.secondary.opacity(0.1))
            .cornerRadius(16)
            .padding()
            Button(action: { viewModel.toggleCompletion(for: habit.id, date: Date()) }) {
                HStack {
                    Image(systemName: "checkmark")
                        .foregroundStyle(.white)
                    Text("Completed today")
                        .foregroundStyle(.white)
                    
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(12)
            }
        }
    }
    
}


#Preview {
    HabitDetailView(viewModel: HabitViewModel(), habit: Habit(name: "FFF ЗАЛЬЧИК", completedDates: []))
}
