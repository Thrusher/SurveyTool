//
//  SurveyViewModel.swift
//  SurveyTool
//
//  Created by Patryk Drozd on 22/01/2025.
//

import SwiftData
import SwiftUI

class SurveyViewModel: ObservableObject {
    @Published var surveys: [Survey] = []
    
    func loadSurveys(
        using modelContext: ModelContext
    ) {
        if let fetchedSurveys = try? modelContext.fetch(
            FetchDescriptor<Survey>()
        ) {
            surveys = fetchedSurveys.sorted(by: {
                $0.createdAt < $1.createdAt
            })
        }
    }
    
    func addSurvey(
        question: String,
        using modelContext: ModelContext
    ) {
        let newSurvey = Survey(question: question)
        surveys.append(newSurvey)
        modelContext.insert(newSurvey)
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving new survey: \(error)")
        }
    }
    
    func deleteSurvey(
        at offsets: IndexSet,
        using modelContext: ModelContext
    ) {
        for index in offsets {
            let survey = surveys[index]
            surveys.remove(at: index)
            modelContext.delete(survey)
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Error saving after deleting survey: \(error)")
        }
    }
    
    func addResponse(
        to survey: Survey,
        answer: SurveyAnswer,
        using modelContext: ModelContext
    ) {
        if let index = surveys.firstIndex(where: { $0.id == survey.id }) {
            let newResponse = SurveyResponse(answer: answer)
            surveys[index].responses.append(newResponse)
            modelContext.insert(newResponse)
            
            do {
                try modelContext.save()
            } catch {
                print("Error saving response: \(error)")
            }
        }
    }
    
    func getResults(
        for survey: Survey) -> (
            yes: Int,
            no: Int,
            yesPercentage: Double,
            noPercentage: Double
        ) {
            let total = survey.responses.count
            let yesCount = survey.responses.filter { $0.answer == .yes }.count
            let noCount = total - yesCount
            let yesPercentage = total > 0 ?
                (Double(yesCount) / Double(total)) * 100 : 0
            let noPercentage = total > 0 ?
                (Double(noCount) / Double(total)) * 100 : 0
            return (yesCount, noCount, yesPercentage, noPercentage)
        }
}
