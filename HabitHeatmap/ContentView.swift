//
//  ContentView.swift
//  HabitHeatmap
//
//  Created by Ilya Sergeev on 14.02.26.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = HabitViewModel()
    
    let columns = Array(repeating: GridItem(.fixed(30), spacing: 8), count: 7)
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                Text("Overall activity")
                    .font(.title3)
                
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
                NavigationLink(destination: HabitListView(viewModel: viewModel)) {
                    HStack{
                        Image(systemName: "leaf")
                        Text("Show all habits")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
                        
                }
            }
            .padding(.horizontal)
            
            
            
            
        }
        
        
    }
    
}

#Preview {
    ContentView()
}
