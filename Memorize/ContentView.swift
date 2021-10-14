//
//  ContentView.swift
//  Memorize
//
//  Created by Franco on 19/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    let viewModel: EmojiMemoryGame
    
    var body: some View {
        
        VStack {
            
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(Color.blue)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]) {
                    ForEach(viewModel.cards) { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            .font(.largeTitle)
            
            HStack {
                
                Button(action: {
                    
                }, label: {
                    VStack {
                        Image(systemName: "car.fill")
                        Text("Vehicles")
                    }
                })
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    VStack {
                        Image(systemName: "leaf.fill")
                        Text("Fruits")
                    }
                })
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    VStack {
                        Image(systemName: "tortoise.fill")
                        Text("Animals")
                    }
                })
            }
            .padding(.horizontal, 40.0)
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
            } else {
                shape.fill()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}
