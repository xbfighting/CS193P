//
//  ViewController.swift
//  Concentration
//
//  Created by 白旭嘉 on 2019/4/10.
//  Copyright © 2019 白旭嘉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipsCountLabel()
        }
    }
    
    private func updateFlipsCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 1, green: 0.6416963339, blue: 0.1075821444, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipsCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipsCountLabel: UILabel! {
        didSet {
            updateFlipsCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    @IBAction private func newGame(_ sender: UIButton) {
        for index in cardButtons.indices {
            cardButtons[index].setTitle("", for: UIControl.State.normal)
            cardButtons[index].backgroundColor = #colorLiteral(red: 1, green: 0.6416963339, blue: 0.1075821444, alpha: 1)
        }
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCount = 0
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if (card.isFaceUp) {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9952836633, green: 0.9879123569, blue: 1, alpha: 0) :#colorLiteral(red: 1, green: 0.6416963339, blue: 0.1075821444, alpha: 1)
            }
        }
    }
    
//    private var emojiChoices = ["👻","🎃","🥦", "🧶", "🎮", "💸", "🔋", "🥎", "🎱"]
    private var emojiChoices = "👻🎃🥦🧶🎮💸🔋🥎🎱"
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "✕"
    }
}

extension Int {
    var arc4random: Int {
        if (self > 0) {
            return Int(arc4random_uniform(UInt32(self)))
        } else if (self < 0) {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

