//
//  ContentView.swift
//  Memorize
//
//  Created by Franco on 19/08/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .stroke(lineWidth: 3)
            Text("Hello, CS193p!")
                .fontWeight(.bold)
        }
        .padding(.all)
        .foregroundColor(/*@START_MENU_TOKEN@*/.red/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
	
