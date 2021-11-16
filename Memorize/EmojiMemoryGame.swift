//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Franco Camilletti on 06/10/2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    static let Vehicles = ["🛳","🏍","🛵","🚀","🚅","🚜","✈️","🚗","🛴"]
    static let Animals = ["🐓","🐭","🐹","🐻","🐧","🐷","🐶"]
    static let Fruits = ["🍑","🍋","🍒","🥝","🥥","🍓","🥭","🍎","🍌"]
    static let Plants = ["🌷","🌺","🌴","🌱","🌲","🍄"]
    static let Food = ["🍕","🍗","🍖","🍔","🥐","🍟"]
    static let Objects = ["📸","☎️","📱","⏳","⏰","🧨","🔮"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairsOfCards: 6) { pairIndex in
            Vehicles[pairIndex]
        }
    }
    
    //MARK: ViewModel Interpretation
    
    @Published private(set) var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: User Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
