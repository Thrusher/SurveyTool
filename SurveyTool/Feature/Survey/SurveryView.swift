//
//  SurveryView.swift
//  SurveyTool
//
//  Created by Patryk Drozd on 23/01/2025.
//

import SwiftUI

struct SurveryView: View {
    
    let question: String
    
    private var answer: ((SurveyAnswer) -> Void)?
    
    init(question: String, answer: ((SurveyAnswer) -> Void)?) {
        self.question = question
        self.answer = answer
    }
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                Text(question)
                    .font(.title)
                    .padding()
                
                HStack {
                    Button(action: {
                        answer?(.yes)
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
                        answer?(.no)
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
            }
            .padding()
            .background(.thinMaterial)
            .cornerRadius(12)
            .padding()
            .navigationTitle("Survey Details")
            Spacer()
        }
        .background(.gray.opacity(0.7))
    }
}

#Preview {
    SurveryView(question: "Do you like trains", answer: nil)
}
