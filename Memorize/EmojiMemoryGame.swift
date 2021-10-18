//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Franco Camilletti on 06/10/2021.
//

import SwiftUI

class EmojiMemoryGame {
    
    static let vehicles = ["🛳", "🏍", "🛵", "🚀", "🚅", "🚜", "✈️", "🚗", "🛴", "⛵️","🚤","🚑","🚛"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            vehicles[pairIndex]
        }
    }
    
    private(set) var model: MemoryGame<String> = createMemoryGame()
    
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    
    // MARK: - Intent(s)
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
}
