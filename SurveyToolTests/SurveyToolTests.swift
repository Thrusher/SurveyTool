//
//  SurveyTests.swift
//  SurveyTests
//
//  Created by Patryk Drozd on 21/01/2025.
//

import Testing
import SwiftData
@testable import SurveyTool
import Foundation

struct SurveyToolTests {
    @MainActor @Test func testAddSurvey() {
        // Given
        let modelContainer = try! ModelContainer(for: Survey.self,
                                                 SurveyResponse.self)
        let modelContext = modelContainer.mainContext
        let viewModel = SurveyListViewModel()
        
        // When
        viewModel.addSurvey(question: "Test Survey", using: modelContext)
        
        // Then
        #expect(viewModel.surveys.count == 1,
                "A new survey should be added.")
        #expect(viewModel.surveys.first?.question == "Test Survey",
                "The question should match the input.")
    }
    
    @MainActor @Test func testAddResponse() {
        // Given
        let modelContainer = try! ModelContainer(for: Survey.self,
                                                 SurveyResponse.self)
        let modelContext = modelContainer.mainContext
        let viewModel = SurveyListViewModel()
        viewModel.addSurvey(question: "Survey for Response",
                            using: modelContext)
        let survey = viewModel.surveys.first!
        
        // When
        viewModel.addResponse(to: survey, answer: .yes, using: modelContext)
        
        // Then
        #expect(survey.responses.count == 1,
                "One response should be added.")
        #expect(survey.responses.first?.answer == .yes,
                "The response should be 'Yes'.")
    }
    
    @MainActor @Test func testDeleteSurvey() {
        // Given
        let modelContainer = try! ModelContainer(for: Survey.self,
                                                 SurveyResponse.self)
        let modelContext = modelContainer.mainContext
        let viewModel = SurveyListViewModel()
        viewModel.addSurvey(question: "Survey to Delete", using: modelContext)
        
        // When
        viewModel.deleteSurvey(at: IndexSet(integer: 0), using: modelContext)
        
        // Then
        #expect(viewModel.surveys.isEmpty, "The survey should be deleted.")
    }
    
    @MainActor @Test func testGetResults() {
        // Given
        let modelContainer = try! ModelContainer(for: Survey.self,
                                                 SurveyResponse.self)
        let modelContext = modelContainer.mainContext
        let viewModel = SurveyListViewModel()
        viewModel.addSurvey(question: "Survey with Results",
                            using: modelContext)
        let survey = viewModel.surveys.first!
        
        viewModel.addResponse(to: survey, answer: .yes, using: modelContext)
        viewModel.addResponse(to: survey, answer: .no, using: modelContext)
        viewModel.addResponse(to: survey, answer: .yes, using: modelContext)
        
        // When
        let results = viewModel.getResults(for: survey)
        
        // Then
        #expect(results.yes == 2,
                "There should be 2 'Yes' responses.")
        #expect(results.no == 1,
                "There should be 1 'No' response.")
        #expect(abs(results.yesPercentage - 66.7) < 0.1,
                "Yes percentage should be approximately 66.7%.")
        #expect(abs(results.noPercentage - 33.3) < 0.1,
                "No percentage should be approximately 33.3%.")
    }
}
