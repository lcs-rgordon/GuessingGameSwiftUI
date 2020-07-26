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

enum ButtonAction: String {
    case guess = "Guess"
    case newGame = "New Game"
}

struct ContentView: View {
    
    @State private var guessCount = 0
    @State private var correctAnswer = Int.random(in: 1...1000)
    @State private var guess = ""
    @State private var feedback = "\n"
    @State private var gameOver = false
    
    private var buttonTitle: ButtonAction {
        if gameOver {
            return .newGame
        } else {
            return .guess
        }
    }

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
                Button(buttonTitle.rawValue, action: {
                    if gameOver {
                        newGame()
                    } else {
                        checkGuess()
                    }
                })
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

        // Hide the keyboard
        hideKeyboard()

        // Verify that input was valid
        guard let guess = Int(guess), guess >= 1, guess <= 1000 else {
            self.guess = ""
            feedback = "Please provide an integer between 1 and 1000."
            return
        }
        
        // Is the guess correct?
        if guess < correctAnswer {
            feedback = "Guess higher next time!"
        } else if guess > correctAnswer {
            feedback = "Guess lower next time!"
        } else {
            feedback = "You're right! Well done."
            gameOver = true
        }
        
        // Track how many guesses made!
        guessCount += 1
        
        // DEBUG
        print("Guess of \(guess) made against correct answer of \(correctAnswer)")
        
    }
    
    func newGame() {
        guessCount = 0
        correctAnswer = Int.random(in: 1...1000)
        feedback = ""
        guess = ""
        gameOver = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
