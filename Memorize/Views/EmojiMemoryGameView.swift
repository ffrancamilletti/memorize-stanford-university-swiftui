//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Franco on 19/08/2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    var body: some View {
        VStack {
            gameTitle
            HStack {
                themeName
                Spacer()
                score
            }
            .padding(.top, -10.0)
            .padding(.bottom, 10.0)
            .padding(/*@START_MENU_TOKEN@*/.horizontal, 8.0/*@END_MENU_TOKEN@*/)
            gameBody
            Spacer()
            newGameButton
            shuffleButton
        }
        .padding(.all)
    }

    var gameTitle: some View {
        Text("Memorize!")
            .font(.largeTitle)
            .fontWeight(.medium)
            .foregroundColor(Color.blue)
    }
    
    var themeName: some View {
        Text(game.themeName)
            .font(.title2)
            .fontWeight(.bold)
    }
    
    var score: some View {
        Text("Score: \(game.score)")
            .font(.title2)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
        .onAppear {
            withAnimation {
                for card in game.cards {
                    deal(card)
                }
            }
        }
        .foregroundColor(game.themeColor)
        .font(.largeTitle)
    }
    
    var newGameButton: some View {
        Button("New Game!") {
            game.newGame()
        }
        .font(.title)
    }
    
    var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
        .font(.headline)
    }
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: -90), endAngle: Angle (degrees: 20))
                    .padding(DrawingConstants.piePadding)
                    .opacity(DrawingConstants.pieOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear.repeatForever(autoreverses: false).speed(0.7))
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontSize: CGFloat = 32
        static let fontScale: CGFloat = 0.70
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
