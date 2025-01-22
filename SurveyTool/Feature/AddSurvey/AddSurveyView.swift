//
//  AddSurveyView.swift
//  SurveyTool
//
//  Created by Patryk Drozd on 22/01/2025.
//

import SwiftUI

struct AddSurveyView: View {
    enum FocusField: Hashable {
      case field
    }

    @FocusState private var focusedField: FocusField?
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var question: String = ""
    @ObservedObject var viewModel: SurveyViewModel

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your survey question", text: $question)
                    .focused($focusedField, equals: .field)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    if !question.isEmpty {
                        viewModel.addSurvey(question: question,
                                            using: modelContext)
                        dismiss()
                    }
                }) {
                    Text("Save Survey")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(question.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .disabled(question.isEmpty)
            }
            .navigationTitle("New Survey")
        }
        .onAppear {
            self.focusedField = .field
        }        
    }
}
