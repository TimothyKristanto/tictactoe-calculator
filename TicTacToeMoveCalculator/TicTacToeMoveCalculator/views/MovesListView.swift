//
//  MovesListView.swift
//  TicTacToeMoveCalculator
//
//  Created by Timothy on 09/05/23.
//

import SwiftUI

struct MovesListView: View {
    var movesList = [[Int]: Int]()
    var board = [[String]]()
    
    var keys = [[Int]]()
    var values = [Int]()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(movesList: [[Int] : Int], board: [[String]]) {
        self.movesList = movesList
        self.board = board
        
        self.keys = movesList.map{$0.key}
        self.values = movesList.map{$0.value}
    }
    
    var body: some View {
        VStack{
            Text("")
            
            ScrollView{
                // grid
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(keys.indices, id: \.self){ index in
                        MoveCardView(board: board, key: keys[index], value: values[index])
                    }
                }
            }
        }
        .frame(width: Constants.screenWidth)
        .background(Color("Tertiary Color"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack(alignment: .leading) {
                    Text("Moves List")
                        .font(.custom("Futura", size: Constants.screenWidth / 21))
                        .foregroundColor(Color("Primary Color"))
                        .bold()
                }
            }
        }
        
    }
}

struct MovesListView_Previews: PreviewProvider {
    static var previews: some View {
        MovesListView(movesList: [[0,2]: 1], board: [["", "", ""], ["", "", ""], ["", "", ""]])
    }
}
