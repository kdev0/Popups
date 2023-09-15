//
//  BackgroundView.swift
//  
//
//  Created by Konstantin D. on 14.09.2023.
//

import SwiftUI

struct BackgroundView: View {
    let onTap: () -> Void

    var body: some View {
        Color.black
            .opacity(0.1)
            .ignoresSafeArea()
            .onTapGesture(perform: onTap)
    }
}
