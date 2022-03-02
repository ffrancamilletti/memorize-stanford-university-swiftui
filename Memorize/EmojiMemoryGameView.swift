//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Franco on 19/08/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        
        VStack {
            
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(Color.blue)
            
            HStack {
                Text(game.themeName)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("Score: \(game.score)")
                    .font(.title2)
            }
            .padding(.top, -10.0)
            .padding(.bottom, 10.0)
            .padding(/*@START_MENU_TOKEN@*/.horizontal, 8.0/*@END_MENU_TOKEN@*/)
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                    }
                }
            }
            .foregroundColor(game.themeColor)
            .font(.largeTitle)
            
            Button {
                game.newGame()
            } label: {
                Text("New Game!")
            }
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        }
        .padding(.all)
    }
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                    Pie(startAngle: Angle(degrees: -90), endAngle: Angle (degrees: 20))
                        .padding(DrawingConstants.piePadding).opacity(DrawingConstants.pieOpacity)
                    Text(card.content).font(font(in: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.emojiFontScale)
    }
    
    private struct DrawingConstants {
        static let emojiFontScale: CGFloat = 0.70
        static let piePadding: CGFloat = 5
        static let pieOpacity: CGFloat = 0.5
        static let cardOpacity: CGFloat = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
