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
    
    var indexOfOneAndOnluFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnluFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnluFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
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
