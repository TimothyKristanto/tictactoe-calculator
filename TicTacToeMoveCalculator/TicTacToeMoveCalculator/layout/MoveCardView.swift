//
//  MoveCardView.swift
//  TicTacToeMoveCalculator
//
//  Created by Timothy on 09/05/23.
//

import SwiftUI

struct MoveCardView: View {
    var board = [[String]]()
    var key = [Int]() // next move
    var value = 0 // is win
    
    init(board: [[String]], key: [Int], value: Int) {
        self.board = board
        self.key = key
        self.value = value
        
        self.board[key[0]][key[1]] = "X"
    }
    
    var body: some View {
        VStack{
            VStack{
                ForEach(0...2, id: \.self){
                    row in
                    HStack{
                        ForEach(0...2, id: \.self){
                            column in
                            Text(board[row][column])
                                .font(.custom("Futura", size: Constants.screenWidth / 19))
                                .bold()
                                .frame(maxWidth: Constants.screenWidth / 1.85, maxHeight: Constants.screenHeight / 5)
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(Color("Primary Color"))
                                .background(Color("Secondary Color"))
                        }
                    }
                }
            }
            .background(Color("Primary Color"))
            .padding()
            
            HStack{
                Spacer()
                
                Text(value == 1 ? "WIN" : "DRAW")
                    .font(.custom("Futura", size: Constants.screenWidth / 20))
                    .bold()
                    .foregroundColor(Color("Secondary Color"))
                    .padding(.vertical, 5)
                
                Spacer()
            }
            .background(Color("Primary Color"))
        }
        .frame(width: Constants.screenWidth / 2.35, height: Constants.screenHeight / 4.2)
        .background(Color("Secondary Color"))
        .cornerRadius(50)
    }
}

struct MoveCardView_Previews: PreviewProvider {
    static var previews: some View {
        
        MoveCardView(board: [["", "", ""], ["", "", ""], ["", "", ""]], key: [0,0], value: 1)
    }
}
