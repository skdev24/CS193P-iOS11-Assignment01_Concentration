//
//  Focus.swift
//  Focus
//
//  Created by Shivam Dev on 22/02/18.
//  Copyright © 2018 Shivam Dev. All rights reserved.
//

import Foundation

class Focus  {
    
    var cards = [Card]()
    var cardsShuffle = [Card]()
    var indexOfOneAndOnlyOneFaceUpCard: Int?
    var Score = 0
    var flipCard = 0
    
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            cards[index].seenThisCard += 1
            flipCard += 1
            if let matchIndex = indexOfOneAndOnlyOneFaceUpCard, matchIndex != index {
                //Check if card match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    Score += 20
                }
                
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOneFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyOneFaceUpCard = index
            }
        }
        
        if cards[index].seenThisCard >= 3 {
            Score -= 10
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cardsShuffle += [card, card]
        }
        //TODO : Shuffle the cards
        cards = cardsShuffle.shuffled()
    }
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
