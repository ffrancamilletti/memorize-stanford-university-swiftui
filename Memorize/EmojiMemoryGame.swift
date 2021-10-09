//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Franco Camilletti on 06/10/2021.
//

import SwiftUI

class EmojiMemoryGame {
    private(set) var model: MemoryGame<String> = MemoryGame<String>(numberOfPairsOfCards: <#T##Int#>)
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
