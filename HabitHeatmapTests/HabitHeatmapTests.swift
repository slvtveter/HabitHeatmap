//
//  HabitHeatmapTests.swift
//  HabitHeatmapTests
//
//  Created by Ilya Sergeev on 14.02.26.
//

import XCTest
@testable import HabitHeatmap

final class HabitHeatmapTests: XCTestCase {
    
    func testMarkDoneAddsDateToArray() {
        let viewModel = HabitViewModel()
        let testDate = Date()
        
        viewModel.markDone(on: testDate)
        
        XCTAssertEqual(viewModel.habit.completedDates.count, 1)
        XCTAssertTrue(viewModel.habit.completedDates.contains(testDate))
    }
   

}
