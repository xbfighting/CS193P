//
//  Card.swift
//  Concentration
//
//  Created by 白旭嘉 on 2019/4/13.
//  Copyright © 2019 白旭嘉. All rights reserved.
//

import Foundation

struct Card {
    var identifier: Int
    var isFaceUp = false
    var isMatched = false
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
