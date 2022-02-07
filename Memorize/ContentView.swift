//
//  ContentView.swift
//  Memorize
//
//  Created by Franco on 19/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        
        VStack {
            
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(Color.blue)

            HStack {
                Text(viewModel.themeName)
                .font(.title2)
                .fontWeight(.bold)
                
                Spacer()
                
                Text("Score: \(viewModel.score)")
                .font(.title2)
            }
            .padding(.top, -10.0)
            .padding(.bottom, 10.0)
            .padding(/*@START_MENU_TOKEN@*/.horizontal, 8.0/*@END_MENU_TOKEN@*/)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card)
                        }
                    }
                }
            }
            .foregroundColor(viewModel.themeColor)
            .font(.largeTitle)
            
            Button {
                viewModel.newGame()
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
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            } else if card.isMatched {
                shape.opacity(0)
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        Group {
            ContentView(viewModel: game)
        }
    }
}
