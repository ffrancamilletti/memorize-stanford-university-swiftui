//
//  ContentView.swift
//  Memorize
//
//  Created by Franco on 19/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    var vehicles = ["🛳", "🏍", "🛵", "🚀", "🚅", "🚜", "✈️", "🚗", "🛴", "⛵️","🚤","🚑","🚛"]
    var fruits = ["🍊", "🍌", "🍉", "🍇", "🍍", "🍒", "🍓", "🍎", "🥝", "🍑", "🍋"]
    var animals = ["🐭", "🐹", "🐔", "🐸", "🐒", "🐻", "🦁", "🐴", "🐶", "🐷", "🐻‍❄️", "🦊", "🐨", "🐧", "🐮"]
    
    @State var selectedGroup : [String]? = nil
    
    var body: some View {
        
        VStack {
            
            Text("Memorize!")
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundColor(Color.blue)
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 75))]) {
                    ForEach(selectedGroup?.shuffled() ?? [], id: \.self) { emoji in
                        CardView(cardContent: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            .font(.largeTitle)
            
            HStack {
                
                Button(action: {
                        selectedGroup = vehicles
                    }, label: {
                        VStack {
                            Image(systemName: "car.fill")
                            Text("Vehicles")
                    }
                })
                
                Spacer()
                
                Button(action: {
                        selectedGroup = fruits
                    }, label: {
                        VStack {
                            Image(systemName: "leaf.fill")
                            Text("Fruits")
                    }
                })
                
                Spacer()
                
                Button(action: {
                        selectedGroup = animals
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
    var cardContent: String
    @State var faceUp = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 25)
            if faceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(cardContent).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            faceUp = !faceUp
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
