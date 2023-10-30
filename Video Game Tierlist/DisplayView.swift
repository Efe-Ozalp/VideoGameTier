//
//  DisplayView.swift
//  Video Game Tierlist
//
//  Created by Efe Ozalp on 10/26/23.
//

import SwiftUI



struct Item: Identifiable {
    let id = UUID()
    let name: String
    var tier: Tier
}

enum Tier: String, CaseIterable {
    case A, B, C, D
}








struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

