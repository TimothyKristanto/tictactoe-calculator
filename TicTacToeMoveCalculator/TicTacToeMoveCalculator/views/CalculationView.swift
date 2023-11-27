//
//  CalculationView.swift
//  TicTacToeMoveCalculator
//
//  Created by Timothy on 08/05/23.
//

import SwiftUI

struct CalculationView: View {
    
    
    @State var tictactoeBoard: [[String]] = [["", "", ""], ["", "", ""], ["", "", ""]]
    @State var turn: String = "X"
    @State var bestActs = [[Int]: Int]()
    @State var isLoading = false
    @State var showInvalidInputAlert = false
    @State var untappableSquares = [[Int]]()
    @State var isCalculated = false
    
    func checkUntapabbleSquares(){
        var tempBoard = tictactoeBoard
        
        print(tempBoard)
        
        for (index_row, row) in tempBoard.enumerated(){
            for (index_col, col) in row.enumerated(){
                if col == ""{
                    tempBoard[index_row][index_col] = turn
                    
                    let winner = winLoseChecker(board: tempBoard)
                    
                    if(winner == turn){
                        untappableSquares.append([index_row, index_col])
                    }
                    
                    tempBoard[index_row][index_col] = ""
                }
                
            }
        }
    }
    
    func miniMax(){
        var tempTicTacToeBoard = tictactoeBoard
        
        for act in action(board: tempTicTacToeBoard){
            let value = minValue(board: actionResult(board: tempTicTacToeBoard, action: act, turns: "X"))
            if value != -1{
                bestActs[act] = value
            }
            tempTicTacToeBoard[act[0]][act[1]] = ""
        }
    }
    
    func utility(mark: String)->Int{
        if(mark == "X"){
            return 1
        }else if(mark == "O"){
            return -1
        }else{
            return 0
        }
    }
    
    func maxValue(board: [[String]])->Int{
        let winner = winLoseChecker(board: board)
        
        if(winner != ""){
            return utility(mark: winner)
        }
        
        var maxVal = -9999
        
        for act in action(board: board){
            maxVal = max(maxVal, minValue(board: actionResult(board: board, action: act, turns: "X")))
//            board[act[0]][act[1]] = ""
        }
        
        return maxVal
    }
    
    func minValue(board: [[String]])->Int{
        let winner = winLoseChecker(board: board)
        
        if(winner != ""){
            return utility(mark: winner)
        }
        
        var minVal = 9999
        
        for act in action(board: board){
            minVal = min(minVal, maxValue(board: actionResult(board: board, action: act, turns: "O")))
//            board[act[0]][act[1]] = ""
        }
        
        return minVal
    }
    
    func actionResult(board: [[String]], action: [Int], turns: String)->[[String]]{
        var tempBoard = board
        tempBoard[action[0]][action[1]] = turns
        return tempBoard
    }
    
    func action(board: [[String]])->[[Int]]{
        var availableactions = [[Int]]()
        
        for (index_row, row) in board.enumerated(){
            for (index_col, col) in row.enumerated(){
                if(col == ""){
                    availableactions.append([index_row, index_col])
                }
            }
        }
        
        return availableactions
    }
    
    func winLoseChecker(board: [[String]])->String{
        // check row
        for row in board{
            if(row[0] == row[1] && row[0] == row[2] && row[0] != ""){
                return row[0]
            }
        }
        
        // check column
        if(board[0][0] == board[1][0] && board[0][0] == board[2][0] && board[0][0] != ""){
            return board[0][0]
        }
        
        if(board[0][1] == board[1][1] && board[0][1] == board[2][1] && board[0][1] != ""){
            return board[0][1]
        }
        
        if(board[0][2] == board[1][2] && board[0][2] == board[2][2] && board[0][2] != ""){
            return board[0][2]
        }
        
        // check diagonal
        if(board[0][0] == board[1][1] && board[0][0] == board[2][2] && board[0][0] != ""){
            return board[0][0]
        }
        
        if(board[0][2] == board[1][1] && board[0][2] == board[2][0] && board[0][2] != ""){
            return board[0][2]
        }
        
        // is draw
        if(!board[0].contains("") && !board[1].contains("") && !board[2].contains("")){
            return "tie"
        }
        
        return ""
    }
    
    func checkXO()->Bool{
        var x = 0
        var o = 0
        
        for row in tictactoeBoard{
            for mark in row{
                if mark == "X"{
                    x += 1
                }else if mark == "O"{
                    o += 1
                }
            }
        }
        
        if x == o{
            return true
        }
        
        return false
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("Calculate every win and draw possibilities based on certain TicTacToe board condition")
                    .font(.custom("Futura", size: Constants.screenWidth / 20))
                    .foregroundColor(Color("Secondary Color"))
                    .bold()
                    .padding(.top, 5)
                    .padding(.leading, -5)
                
                Spacer()
                
                Text("Your mark is X")
                    .foregroundColor(Color("Primary Color"))
                    .font(.custom("Futura", size: Constants.screenWidth / 20))
                    .bold()
                
                VStack{
                    ForEach(0...2, id: \.self){
                        row in
                        HStack{
                            ForEach(0...2, id: \.self){
                                column in
                                    
                                if(tictactoeBoard[row][column] == ""){
                                    if isCalculated || untappableSquares.contains([row, column]){
                                        Text("")
                                            .font(.custom("Futura", size: Constants.screenWidth / 20))
                                            .bold()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .aspectRatio(1, contentMode: .fit)
                                            .foregroundColor(Color("Secondary Color"))
                                            .background(Color("Tertiary Color"))
                                    }else{
                                        Text("Tap here")
                                            .font(.custom("Futura", size: Constants.screenWidth / 20))
                                            .bold()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .aspectRatio(1, contentMode: .fit)
                                            .foregroundColor(Color("Secondary Color"))
                                            .background(Color("Tertiary Color"))
                                            .onTapGesture {
                                                untappableSquares = [[Int]]()
                                                
                                                tictactoeBoard[row][column] = turn
                                                
                                                if(turn == "X"){
                                                    turn = "O"
                                                }else{
                                                    turn = "X"
                                                }
                                                
                                                checkUntapabbleSquares()
                                            }
                                    }
                                }else{
                                    Text(tictactoeBoard[row][column])
                                        .font(.custom("Futura", size: Constants.screenWidth / 5))
                                        .bold()
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .aspectRatio(1, contentMode: .fit)
                                        .foregroundColor(Color("Primary Color"))
                                        .background(Color("Tertiary Color"))
                                }
                            }
                        }
                    }
                }
                .background(Color("Primary Color"))
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                Text("Turn: \(turn)")
                    .foregroundColor(Color("Primary Color"))
                    .font(.custom("Futura", size: Constants.screenWidth / 20))
                    .bold()
                    .padding(.top, 10)
                
                Spacer()
                
                Text("Win/Draw Possibilities: \(bestActs.count)")
                    .font(.custom("Futura", size: Constants.screenWidth / 22))
                    .bold()
                    .foregroundColor(Color("Primary Color"))
                
                if !isLoading{
                    HStack{
                        if bestActs.count > 0{
                            NavigationLink(destination: MovesListView(movesList: bestActs, board: tictactoeBoard)){
                                Text("See All Moves")
                                    .padding(.vertical, 13)
                                    .padding(.horizontal, Constants.screenWidth / 10)
                                    .background(Color("Primary Color"))
                                    .foregroundColor(Color("Tertiary Color"))
                                    .cornerRadius(10)
                                    .font(.custom("Futura", size: Constants.screenWidth / 23))
                                    .bold()
                            }
                        }else{
                            Button{
                                isLoading = true
                                
                                let isValid = checkXO()
                                if isValid{
                                    isCalculated = true
                                    miniMax()
                                }else{
                                    showInvalidInputAlert = true
                                }
                                
                                isLoading = false
                            }label: {
                                Text("Calculate")
                                    .padding(.vertical, 13)
                                    .padding(.horizontal, Constants.screenWidth / 6.5)
                                    .background(Color("Primary Color"))
                                    .foregroundColor(Color("Tertiary Color"))
                                    .cornerRadius(10)
                                    .font(.custom("Futura", size: Constants.screenWidth / 23))
                                    .bold()
                            }
                            .alert(isPresented: $showInvalidInputAlert) {
                                Alert(title: Text("Invalid Board Input"), message: Text("The numbers of the X mark must be the same as the numbers of the O mark!"), dismissButton: .default(Text("OK")))
                            }
                        }
                        
                        
                        Button{
                            tictactoeBoard = [["", "", ""], ["", "", ""], ["", "", ""]]
                            turn = "X"
                            bestActs = [[Int]: Int]()
                            untappableSquares = [[Int]]()
                            isCalculated = false
                        }label: {
                            Text("Reset")
                                .padding(.vertical, 13)
                                .padding(.horizontal, Constants.screenWidth / 25)
                                .background(.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .font(.custom("Futura", size: Constants.screenWidth / 23))
                                .bold()
                        }
                    }
                }else{
                    CircleLoadingView()
                }
                
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .frame(width: Constants.screenWidth)
            .background(Color("Tertiary Color"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem (placement: .navigationBarLeading) {
                    VStack(alignment: .leading) {
                        Text("TicTacToe Calculator")
                            .font(.custom("Futura", size: Constants.screenWidth / 20 + 5))
                            .foregroundColor(Color("Primary Color"))
                            .bold()
                    }
                    .padding([.top, .leading], 10)
                }
            }
        }
        .tint(Color("Primary Color"))
    }
}

struct CalculationView_Previews: PreviewProvider {
    static var previews: some View {
        CalculationView()
    }
}
