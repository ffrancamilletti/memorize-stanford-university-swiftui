//
//  ContentView.swift
//  Memorize
//
//  Created by Franco on 19/08/2021.
//

import SwiftUI

struct ContentView: View {
    
    var emojis = ["🛳", "🏍", "🛵", "🚀", "🚅", "🚜", "✈️", "🚗", "🛴", "⛵️"]
    @State var emojiCount = 6
    
    var body: some View {
        VStack {
            HStack {
                ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                    CardView(cardContent: emoji)
                }
            }
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
            .padding(.horizontal)
            .font(.largeTitle)
        }
        .padding(.all)
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
    }
    
    var remove: some View {
        Button {
            if emojiCount > 1 {
            emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }
    }
    
    var add: some View {
        Button {
            if emojiCount < emojis.count {
            emojiCount += 1
            }
        } label: {
            Image(systemName: "plus.circle")
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
        }
    }
}

struct CardView: View {
    var cardContent: String
    @State var faceUp = true
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            if faceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
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
