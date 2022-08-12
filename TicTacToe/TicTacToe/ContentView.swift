//
//  ContentView.swift
//  TicTacToe
//
//  Created by GOURAVM on 12/08/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
         
        NavigationView {
            HomeView()
                .navigationTitle("Tic Tac Toe")
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
