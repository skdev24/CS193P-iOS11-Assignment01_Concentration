//
//  ViewController.swift
//  Focus
//
//  Created by Shivam Dev on 22/02/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    lazy var game = Focus(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    var emojis = ["😈", "👹", "👺", "🎃", "👻", "🤡"]
    var emojiChoice = [String]()
    var cardValue = [Focus]()
    
    @IBOutlet weak var flipCount: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var displayScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiChoice = emojis
        newGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        if let cardNumber = cardButtons.index(of: sender) {
            
            game.chooseCard(at: cardNumber)
            updaateViewFromModel()
        } else {
            print("Chossen card was not in cardButtons")
        }
    }
    
    func updaateViewFromModel() {
        var count = 0
        var count2 = 0
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor =  card.isMatched ? #colorLiteral(red: 0.9479038119, green: 0.5719761252, blue: 0.2384497225, alpha: 0) : #colorLiteral(red: 0.9479038119, green: 0.5719761252, blue: 0.2384497225, alpha: 1)
            }
        }
        for i in 0..<cardButtons.count {
            if cardButtons[i].backgroundColor == #colorLiteral(red: 0.9479038119, green: 0.5719761252, blue: 0.2384497225, alpha: 0) {
                cardButtons[i].setImage(#imageLiteral(resourceName: "holloween"), for: .normal)
                count += 1
            }
            if cardButtons[i].backgroundColor != #colorLiteral(red: 0.9479038119, green: 0.5719761252, blue: 0.2384497225, alpha: 1) {
                count2 += 1
                
            }
        }
        if count2 == 12 {
            let alert = UIAlertController(title: "GAME OVER", message: "FINAL SCORE : \(game.Score)\nTOTAL FLIPS : \(game.flipCard)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "PLAY AGAIN", style: UIAlertActionStyle.default, handler: { _ in
                self.newGame()
            }))
            self.present(alert, animated: true, completion: nil)
        }
        displayScore.text = "SCORE : \(game.Score)"
        flipCount.text = "FLIPS : \(game.flipCard)"
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoice.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoice.count)))
            emoji[card.identifier] = emojiChoice.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
    func newGame() {
        emoji = [:]
        emojiChoice = emojis
        game.Score = 0
        game.flipCard = 0
        
        for i in 0..<cardButtons.count {
            game.cards[i].isMatched = false
            game.cards[i].isFaceUp = false
            cardButtons[i].setImage(nil, for: .normal)
        }
        updaateViewFromModel()
    }
}
