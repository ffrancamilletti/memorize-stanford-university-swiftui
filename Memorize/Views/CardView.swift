//
//  CardView.swift
//  Memorize
//
//  Created by Franco Camilletti on 16/03/2022.
//

import SwiftUI

struct CardView: View {
    
    let card: EmojiMemoryGame.Card
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: (1-animatedBonusRemaining)*360-90))
                            .onAppear {
                                withAnimation {
                                    animatedBonusRemaining = card.bonusRemaining
                                    withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                        animatedBonusRemaining = 0
                                    }
                                }
                            }
                    } else {
                        Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle (degrees: (1-card.bonusRemaining)*360-90))
                    }
                }
                .padding(5)
                .opacity(0.5)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear.repeatForever(autoreverses: false).speed(DrawingConstants.spinSpeed) : .default)
                    .scaleEffect(scale(thatFits: geometry.size))
                    .font(Font.system(size: DrawingConstants.fontSize))
            }
            .cardify(isFaceUp: card.isFaceUp)
        }
    }
    
    private func scale(thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    
    private struct DrawingConstants {
        static let fontSize: CGFloat = 27
        static let fontScale: CGFloat = 0.70
        static let spinSpeed: Double = 0.7
    }
}
