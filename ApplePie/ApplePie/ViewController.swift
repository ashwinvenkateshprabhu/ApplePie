//
//  ViewController.swift
//  ApplePie
//
//  Created by Ashwin V Prabhu on 7/13/17.
//  Copyright © 2017 Ashwin Venkatesh Prabhu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 8
    var totalWins = 0 {
        didSet {
            NewRound()
        }
    }
    var totalLoss = 0 {
        didSet {
            NewRound()
        }
    }
    var currentGame: Game!
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NewRound()
    }
    
    func NewRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            EnableLetterButtons(true)
            UpdateUI()
        } else {
            EnableLetterButtons(false)
        }
    }
    
    func EnableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func UpdateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLoss)"
        treeImageView.image = UIImage(named: "tree-\(currentGame.incorrectMovesRemaining)")
    }
    
    func UpdateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLoss += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        }
        UpdateUI()
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.PlayerGuessed(letter: letter)
        UpdateGameState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

