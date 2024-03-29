//
//  HangmanGame.swift
//  Hangman
//
//  Created by Yichen Sun on 9/22/17.
//  Copyright © 2017 iOS DeCal. All rights reserved.
//

import Foundation

class HangmanGame {
    
    var guessed: [Character]
    var wrongGuesses: [Character]
    let word: String
    let hangmanPhrases = HangmanPhrases()
    
    init() {
        self.wrongGuesses = []
        self.word = hangmanPhrases.getRandomPhrase()
        //initializes array with underscores the length of the string
        self.guessed = Array(repeating: "_", count: strlen(self.word))
        //replace underscores with whitespace where needed
        for i in 0...strlen(self.word) - 1 {
            let index = self.word.index(self.word.startIndex, offsetBy: i)
            if (String(self.word[index]) == " ") {
                self.guessed[i] = " "
            }
        }
    }
    //returns true if guess was in word, else false
    //in controller: if true, update display of guessed characters; else, update image of hangman
    func takeTurn(game: HangmanGame, guess: Character) -> Bool {
        //if guess is correct, change values of guessed array to reflect the correct guess
        if (game.word.characters.contains(guess)) {
            for i in 0...strlen(game.word) - 1 {
                let index = game.word.index(game.word.startIndex, offsetBy: i)
                if (game.word[index] == guess) {
                    game.guessed[i] = guess
                }
            }
            return true
        }
        else {
            if (!game.wrongGuesses.contains(guess)) {
                game.wrongGuesses.append(guess)
            }
            return false
        }
    }
    
    //returns true if player can continue to take turns
    func can_continue(game: HangmanGame) -> Bool {
        if (game.wrongGuesses.count >= 6 || !guessed.contains("_")) {
            return false
        }
        return true
    }
    
    //returns true if player won, false if player lost
    //call after can_continue returns false
    func did_win(game: HangmanGame) -> Bool {
        if (game.wrongGuesses.count >= 6) {
            return false
        }
        return true
    }
    //initializes and returns a new game
    //remember to also reset UI elements w/ ViewController!!
    func startNewGame() -> HangmanGame {
        return HangmanGame()
    }
}
