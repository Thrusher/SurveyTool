//
//  SurveyListView.swift
//  Survey
//
//  Created by Patryk Drozd on 21/01/2025.
//

import SwiftUI

struct SurveyListView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = SurveyViewModel()
    @State private var showingAddSurvey = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.surveys) { survey in
                        NavigationLink(
                            destination: SurveyDetailView(
                                survey: survey,
                                viewModel: viewModel
                            )
                        ) {
                            VStack(alignment: .leading) {
                                Text(survey.question)
                                    .font(.headline)
                                let results = viewModel.getResults(for: survey)
                                Text("Yes: \(results.yes) (\(String(format: "%.1f", results.yesPercentage))%) | No: \(results.no) (\(String(format: "%.1f", results.noPercentage))%)")
                                    .font(.subheadline)
                            }
                        }
                    }
                    .onDelete { offsets in
                        viewModel.deleteSurvey(at: offsets, using: modelContext)
                    }
                }
                .listStyle(InsetGroupedListStyle())

                Button(action: { showingAddSurvey.toggle() }) {
                    Text("Add New Survey")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Surveys")
            .sheet(isPresented: $showingAddSurvey) {
                AddSurveyView(viewModel: viewModel)
            }
            .onAppear {
                viewModel.loadSurveys(using: modelContext)
            }
        }
    }
}
