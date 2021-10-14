//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Franco on 19/08/2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
