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

    var body: some View {
        VStack(spacing: 30) {
            Group {
                Spacer()
                Text("I'm thinking of a number between 0 and 1000.")
                    .font(.title)
                    .multilineTextAlignment(.center)
                Text("Guess it!")
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
            Group {
                Spacer()
                TextField("Enter your guess", text: $guess)
                    .frame(width: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                Spacer()
                Button("Guess") {
                    checkGuess()
                }
            }
            Group {
                Spacer()
                Text("\(guessCount) guesses made.")
                    .multilineTextAlignment(.center)
                Spacer()
            }
        }
    }
    
    func checkGuess() {
        
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
