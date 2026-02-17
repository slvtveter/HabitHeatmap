//
//  HabitListView.swift
//  HabitHeatmap
//
//  Created by Ilya Sergeev on 16.02.26.
//
import SwiftUI

struct HabitListView: View {
    @ObservedObject var viewModel: HabitViewModel
    @State private var showingAddSheet = false
    @State private var newName = ""
    var body: some View {
        List {
            ForEach(viewModel.habits) { habit in
                NavigationLink(destination: HabitDetailView(viewModel: viewModel, habit: habit)) {
                    VStack {
                        Text(habit.name)
                    }
                }
                
                
            }.onDelete(perform: viewModel.deleteHabit)
        }
        .navigationTitle("List of habits")
        .toolbar {
            Button(action: { showingAddSheet = true }) {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            NavigationView {
                Form {
                    Section("Habit details") {
                        TextField("Name ", text: $newName)
                    }
                    Button (action: {
                        if !newName.isEmpty {
                            viewModel.addHabit(name: newName)
                            newName = ""
                            showingAddSheet = false
                        }
                    }) {
                        HStack {
                            Image(systemName: "pencil.and.scribble")
                            Text("Enter the habit")
                        }
                    }
                }
                .navigationTitle("Add habit")
            }
        }
        
    }
}
#Preview {
    HabitListView(viewModel: HabitViewModel())
}
