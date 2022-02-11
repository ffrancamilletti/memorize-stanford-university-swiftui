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
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(game.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                game.choose(card)
                            }
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
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: DrawingConstants.lineWidth)
                    Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
            }
        }
    }
    
    private func font (in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * DrawingConstants.emojiFontScale)
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let emojiFontScale: CGFloat = 0.7
    }
    
}

















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            EmojiMemoryGameView(game: game)
        }
    }
}
