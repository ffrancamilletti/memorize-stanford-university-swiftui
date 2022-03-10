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
    
    private func deal(_ card: MemoryGame<String>.Card) {
        dealt.insert(card.id)
    }
    
    private func undeal(_ card: MemoryGame<String>.Card) {
        dealt.removeAll()
    }
    
    private func isUndealt(_ card: MemoryGame<String>.Card) -> Bool {
        !dealt.contains(card.id)
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
            deckBody
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
        AspectVGrid(items: game.cards, aspectRatio: CardConstants.aspectRatio) { card in
            if isUndealt(card) || card.isMatched && !card.isFaceUp {
                Color.clear
            } else {
                CardView(card: card)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity).animation(.easeInOut))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(game.themeColor)
        .font(.largeTitle)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUndealt)) { card in
                CardView(card: card)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(game.themeColor)
        .onTapGesture {
                withAnimation {
                    for card in game.cards {
                        deal(card)
                    }
                }
        }
    }
    
    var newGameButton: some View {
        Button("New Game!") {
            for card in game.cards {
                undeal(card)
            }
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
    
    private struct CardConstants {
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

struct CardView: View {
    
    let card: MemoryGame<String>.Card
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Pie(startAngle: Angle(degrees: DrawingConstants.startAngle), endAngle: Angle (degrees: DrawingConstants.endAngle))
                    .padding(DrawingConstants.piePadding)
                    .opacity(DrawingConstants.pieOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear.repeatForever(autoreverses: false).speed(DrawingConstants.spinSpeed))
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
        static let startAngle: CGFloat = -90
        static let endAngle: CGFloat = 20
        static let piePadding: CGFloat = 5
        static let pieOpacity: CGFloat = 0.5
        static let fontSize: CGFloat = 32
        static let fontScale: CGFloat = 0.70
        static let spinSpeed: Double = 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
    }
}
