//
//  HomeView.swift
//  TicTacToe
//
//  Created by GOURAVM on 12/08/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var moves: [String] = Array(repeating: "", count: 9)
    @State var isPlaying = false
    @State var msg = ""
    @State var gameOver = false
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(minimum: 100, maximum: 100),spacing:20), count: 3),spacing: 15) {
            ForEach(0..<9,id:\.self){ index in
                ZStack {
                    Color.green
                    Color.white.opacity(moves[index] == "" ? 1: 0)
                    
                       Text(moves[index])
                        .font(.system(size: 55))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                }
                .frame(width: getWidth(), height: getWidth(), alignment: .center)
                .cornerRadius(getWidth()/2)
                .rotation3DEffect(.init(degrees: moves[index] != ""  ? 180 : 0), axis: (x: 0.0, y: 2.0, z: 0.0), anchor: .center, anchorZ: 0.1, perspective: 0.5)
                .onTapGesture {
                    withAnimation(Animation.interactiveSpring()){
                        moves[index] = isPlaying ? "X" : "0"
                        isPlaying.toggle()
                    }
                }
            }
        }
        .onChange(of: moves) { value in
            checkWinner()
        }
        .alert(isPresented: $gameOver) {
            Alert(title: Text("Winner"), message: Text(msg), dismissButton:.destructive(Text("Play Again?"), action: {
                withAnimation(Animation.easeIn(duration: 0.5)) {
                    moves.removeAll()
                    moves = Array(repeating: "", count: 9)
                    isPlaying = true
                }
            }))
        }
      
    }
    
    func getWidth()->CGFloat {
        // horizontal padding = 30
        // spacing = 30
        let width = UIScreen.main.bounds.width - (30 + 30)
        return width / 3
    }
    
    func checkWinner(){
        if checkMoves(player: "X"){
            msg = "Player X Won !!!"
            gameOver.toggle()
        }
        else
        if checkMoves(player: "0"){
            msg = "Player 0 Won !!!"
            gameOver.toggle()
        }
        else {
            let status = moves.contains { value in
                return value == ""
            }
            if !status {
                msg = "Game Over Tied  !!!"
                gameOver.toggle()
            }
            
        }
    }
    func checkMoves(player:String)->Bool{
        for i in stride(from: 0, to: 9, by: 3){
            if moves[i] == player && moves[i+1] == player && moves[i+2] == player{
                return true
            }
        }
        for i in 0...2{
            if moves[i] == player && moves[i+3] == player && moves[i+6] == player{
                return true
            }
        }
        
        if moves[0] == player && moves[4] == player && moves[8] == player{
            return true
        }
        
        if moves[2] == player && moves[4] == player && moves[6] == player{
            return true
        }
        
        
        return false
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

