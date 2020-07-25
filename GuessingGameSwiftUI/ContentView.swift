//
//  ContentView.swift
//  GuessingGameSwiftUI
//
//  Created by Russell Gordon on 2020-07-25.
//

import SwiftUI

// SOURCE: https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
}
#endif

struct ContentView: View {
    
    @State private var guessCount = 0
    @State private var correctAnswer = Int.random(in: 1...1000)
    @State private var guess = ""
    @State private var feedback = "\n"
    
    var body: some View {
        VStack(spacing: 30) {
            Group {
                Text("Guessing Game")
                    .font(.largeTitle)
                    .padding(.top)
                Spacer()
                TextField("Enter your guess", text: $guess)
                    .keyboardType(.numberPad)
                    .font(.title2)
                Button("Guess") {
                    checkGuess()
                }
            }
            Group {
                Text("\(feedback)")
                    .minimumScaleFactor(0.75)
                Text("\(guessCount) guesses made.")
                    .minimumScaleFactor(0.75)
                Spacer()
            }
            .padding(.trailing)
            .padding(.leading)
        }
        .multilineTextAlignment(.center)
    }
    
    func checkGuess() {
        
        // Verify that input was valid
        guard let guess = Double(guess) else {
            self.guess = ""
            feedback = "Please provide an integer between 1 and 1000."
            return
        }
        
        hideKeyboard()
        guessCount += 1
        print("Guess made")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
