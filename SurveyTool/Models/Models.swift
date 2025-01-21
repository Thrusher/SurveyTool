//
//  Models.swift
//  SurveyTool
//
//  Created by Patryk Drozd on 22/01/2025.
//

import SwiftData
import Foundation

@Model
class Survey: Identifiable {
    var id: UUID
    var question: String
    var responses: [SurveyResponse]
    @Attribute var createdAt: Date

    init(id: UUID = UUID(),
         question: String,
         responses: [SurveyResponse] = [],
         createdAt: Date = Date()) {
        self.id = id
        self.question = question
        self.responses = responses
        self.createdAt = createdAt
    }
}

enum SurveyAnswer: String, Codable {
    case yes = "Yes"
    case no = "No"
}

@Model
class SurveyResponse: Identifiable {
    var id: UUID
    var answer: SurveyAnswer
    var timestamp: Date

    init(id: UUID = UUID(),
         answer: SurveyAnswer,
         timestamp: Date = Date()) {
        self.id = id
        self.answer = answer
        self.timestamp = timestamp
    }
}
