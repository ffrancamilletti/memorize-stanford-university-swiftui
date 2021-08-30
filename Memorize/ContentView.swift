//
//  ContentView.swift
//  Memorize
//
//  Created by Franco on 19/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView()
            CardView()
            CardView()
            CardView()
        }
        .padding(.all).foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
    }
}

struct CardView: View {
    @State var faceUp = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
            if faceUp {
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text("🥵").font(.largeTitle)
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
