//
//  CircleLoadingView.swift
//  TicTacToeMoveCalculator
//
//  Created by Timothy on 10/05/23.
//

import SwiftUI

struct CircleLoadingView: View {
    var body: some View {
        VStack {
            ProgressView() // show the loading indicator
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5)
        }
    }
}

struct CircleLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        CircleLoadingView()
    }
}
