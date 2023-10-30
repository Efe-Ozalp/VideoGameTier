//
//  ContentView.swift
//  Video Game Tierlist
//
//  Created by Efe Ozalp on 10/24/23.
//
import Firebase
import SwiftUI

struct ContentView: View {
    
    func saveToFirebase() {
        // Reference to the Firestore database
        let db = Firestore.firestore()
        
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        ref = db.collection("gameRankings").addDocument(data: [
            "gameName": gameName,
            "rank": selectedLetter
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    let letters = ["A", "B", "C", "D"]
    @State private var selectedLetter = "A"
    @State private var gameName:String = ""
    
    var body: some View {
        VStack {
            
            var displayMessage: String {
                    if gameName.isEmpty {
                        return "Please enter a game name."
                    } else {
                        return "You ranked \(gameName) as Tier \(selectedLetter). Confirm?"
                    }
                }
            
            Text("Video Game Tierlist Maker")
                .font(.largeTitle)
                .bold()
            HStack {
                TextField("Enter Game Name", text: $gameName)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                Picker(selection: $selectedLetter, label: Text("Select a Letter")) {
                    ForEach(letters, id: \.self) { letter in
                        Text(letter).tag(letter)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(width: 100, height: 150, alignment: .center)
                
            }
            Text(displayMessage)
                            .font(.largeTitle)
                            .padding()
            Button(action: {
                saveToFirebase()
            }) {
                Text("Save Ranking")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(20)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(1), Color.green.opacity(1)]), startPoint: .top, endPoint: .bottom))
                    .overlay(
                        RoundedRectangle(cornerRadius:100)
                            .stroke(Color.black.opacity(1), lineWidth: 5)
                    )
                    .cornerRadius(100)
                   
            }
            .padding()
            
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
