//
//  SurveyDetailView.swift
//  SurveyTool
//
//  Created by Patryk Drozd on 22/01/2025.
//

import SwiftUI

struct SurveyDetailView: View {
    let survey: Survey
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: SurveyViewModel

    var body: some View {
        VStack {
            Text(survey.question)
                .font(.title)
                .padding()
            
            HStack {
                Button(action: {
                    viewModel.addResponse(to: survey,
                                          answer: .yes,
                                          using: modelContext)
                    dismiss()
                }) {
                    Text("Yes")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Button(action: {
                    viewModel.addResponse(to: survey,
                                          answer: .no,
                                          using: modelContext)
                    dismiss()
                }) {
                    Text("No")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            Spacer()
        }
        .navigationTitle("Survey Details")
    }
}
