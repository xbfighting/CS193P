//
//  Concertration.swift
//  Concentration
//
//  Created by 白旭嘉 on 2019/4/13.
//  Copyright © 2019 白旭嘉. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnluFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnluFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnluFaceUpCard = nil
            } else {
                // either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnluFaceUpCard = index
            }
            
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        Card.identifierFactory = 0
        cards = [Card]()
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // Shuffle the cards
        shuffleCards()
    }
    
    func shuffleCards() {
        for cardIndex in cards.indices {
            let randomSeed = cards.count - cardIndex
            let randomIndex = Int(arc4random_uniform(UInt32(randomSeed))) + cardIndex
            
            // switch
            let tempCard = cards[cardIndex]
            cards[cardIndex] = cards[randomIndex]
            cards[randomIndex] = tempCard
        }
    }
}
