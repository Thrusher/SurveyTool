//
//  SurveyToolApp.swift
//  Survey
//
//  Created by Patryk Drozd on 21/01/2025.
//

import SwiftUI
import SwiftData

@main
struct SurveyToolApp: App {
    var container: ModelContainer

    init() {
        do {
            container = try ModelContainer(
                for: Survey.self, SurveyResponse.self,
                configurations: ModelConfiguration("SurveyData")
            )
            
            if CommandLine.arguments.contains("--reset-database") {
                try clearDatabase(container: container)
            }
        } catch {
            fatalError("Failed to configure SwiftData container: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            SurveyListView()
                .modelContainer(container)
        }
    }
    
    private func clearDatabase(container: ModelContainer) throws {
        let context = container.mainContext
        let surveys = try context.fetch(FetchDescriptor<Survey>())
        for survey in surveys {
            context.delete(survey)
        }
        try context.save()
    }
}
