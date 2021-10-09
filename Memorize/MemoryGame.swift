//
//  MemoryGame.swift
//  Memorize
//
//  Created by Franco Camilletti on 06/10/2021.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    
    func choose (_ card: Card) {
        
    }
    
    init(numberOfPairsOfCards: Int) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            cards.append(Card(content: <#T##CardContent#>))
            cards.append(Card(content: <#T##CardContent#>))
        }
    }
    
    struct Card {
        var isFaceUP: Bool = false
        var isMatched: Bool = false
        var content: CardContent
    }
}
