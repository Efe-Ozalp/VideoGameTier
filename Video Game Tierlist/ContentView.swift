//
//  ContentView.swift
//  Video Game Tierlist
//
//  Created by Efe Ozalp on 10/24/23.
//

import SwiftUI

struct ContentView: View {
    @State private var gameName:String = ""
    
    var body: some View {
        VStack {
            Text("Video Game Tierlist Maker")
                .font(.largeTitle)
                .bold()
            TextField("Enter Game Name", text: $gameName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
            Button("Save Ranking")
            {
                //Save to firebase
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
