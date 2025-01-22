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
    @State private var selectedSurvey: Survey?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.surveys) { survey in
                        Button(action: {
                            selectedSurvey = survey
                        }) {
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
            .sheet(item: $selectedSurvey) { survey in
                SurveyDetailView(survey: survey, viewModel: viewModel)
                    .presentationDetents([.medium, .fraction(0.5)])
                    .presentationDragIndicator(.visible)
            }
            .onAppear {
                viewModel.loadSurveys(using: modelContext)
            }
        }
    }
}
