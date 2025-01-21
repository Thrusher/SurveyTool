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
            container = try ModelContainer(for: Survey.self,
                                           SurveyResponse.self)
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
}
