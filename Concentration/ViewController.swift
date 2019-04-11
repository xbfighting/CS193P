//
//  ViewController.swift
//  Concentration
//
//  Created by 白旭嘉 on 2019/4/10.
//  Copyright © 2019 白旭嘉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var flipCount = 0 {
        didSet {
            flipsCountLabel.text = "Flips: \(flipCount)"
        }
    }
    var emojiList = ["👻","🎃","👻","🎃","👻","🎃"]

    @IBOutlet weak var flipsCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            if emojiList.count > cardNumber {
                flipCard(withEmoji: emojiList[cardNumber], on: sender)
            }
        } else {
            print("card not be inited")
        }
        
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.6416963339, blue: 0.1075821444, alpha: 1)
        } else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    

    
}

