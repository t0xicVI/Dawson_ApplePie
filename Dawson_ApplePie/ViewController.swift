//
//  ViewController.swift
//  Dawson_ApplePie
//
//  Created by Dawson Michaels on 3/4/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var ImageView1: UIImageView!
    
    @IBOutlet weak var CorrectWordLabel: UILabel!
    
    @IBOutlet weak var ScoreLabel: UILabel!
    
    
    @IBOutlet var LetterButtons: [UIButton]!
    
    var words = ["apple", "orange", "banana", "pear"]
    
    let lives = 7
    
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

    
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
    }
    
    func newRound(){
        if !words.isEmpty {
            let newWord = words.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining:
            lives, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        }
        else {
            enableLetterButtons(false)
        }
        

    }

    func enableLetterButtons(_ enable: Bool) {
        for button in LetterButtons {
            button.isEnabled = enable
        }
    }

    
    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }

        let wordWithSpacing = letters.joined(separator: " ")
        CorrectWordLabel.text = wordWithSpacing
        ScoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        ImageView1.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")

    }
    
    @IBAction func ButtonPress(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        }
        else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        else {
            updateUI()
        }

    }
    
}

