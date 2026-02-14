//
//  ContentView.swift
//  HabitHeatmap
//
//  Created by Ilya Sergeev on 14.02.26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HabitViewModel()
    let columns = Array(repeating: GridItem(.fixed(30), spacing: 5), count: 7)
    var body: some View {
        //NavigationStack {
            HStack {
                Text("Streak: \(viewModel.habit.completedDates.count)")
            }
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(viewModel.lastDays(28), id: \.self) { date in
                    Rectangle()
                        .fill(viewModel.habit.completedDates.contains { Calendar.current.isDate($0, inSameDayAs: date)} ? Color.green : Color.green.opacity(0.2))
                        .frame(width: 30, height: 30)
                        .cornerRadius(8)
                }
            }
            Button(action: {viewModel.markDone(on: Date())}){
                Text("Complete today!")
            }
       
            Button(action: { viewModel.remark() }) {
                Text("Delete last")
            }
            
          //  .navigationTitle(viewModel.habit.name)
       // }
    }
}

#Preview {
    ContentView()
}
