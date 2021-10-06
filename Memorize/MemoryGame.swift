//
//  MemoryGame.swift
//  Memorize
//
//  Created by Franco Camilletti on 06/10/2021.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose (_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUP: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
