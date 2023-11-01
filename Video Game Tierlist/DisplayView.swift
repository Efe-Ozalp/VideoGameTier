//
//  DisplayView.swift
//  Video Game Tierlist
//
//  Created by Efe Ozalp on 10/26/23.
//

import SwiftUI
import FirebaseFirestore

struct Game: Identifiable {
    var id: String // document ID from Firestore
    var name: String
    var rank: String
}


struct DisplayView: View {
    @State private var games: [Game] = []
    
    var body: some View {
        VStack {
            HStack{
                Text("Video Game Tierlist")
                    .font(.title)
                    .bold()
                    .foregroundColor(.blue)
                Image(systemName: "gamecontroller.fill")
                    .foregroundColor(.blue)
            }
            Spacer(minLength: 8)
            HStack{
                Text("  Game Name")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.blue)
                Spacer()
                Text("Tier Ranking  ")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.blue)
            }
            
            ScrollView {
                
                ForEach(games) { game in
                    HStack {
                        Text(game.name)
                        Spacer()
                        Text("Tier \(game.rank)")
                            .bold()
                    }
                    .padding(10)
                }
            }
            .onAppear(perform: fetchGames)
        }
    }
    
    func fetchGames() {
        let db = Firestore.firestore()
        
        db.collection("gameRankings").order(by: "rank").order(by: "gameName").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting documents: \(error)")
            } else {
                print("Successfully retrieved \(querySnapshot!.documents.count) documents.")
                self.games = querySnapshot!.documents.compactMap { document in
                    let data = document.data()
                    print("Document data: \(data)") // This will print each document's data
                    let id = document.documentID
                    let gameName = data["gameName"] as? String ?? ""
                    let rank = data["rank"] as? String ?? ""
                    
                    return Game(id: id, name: gameName, rank: rank)
                }
            }
        }
    }
    
}

struct DisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayView()
    }
}
