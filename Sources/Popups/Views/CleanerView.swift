//
//  CleanerView.swift
//  
//
//  Created by Konstantin D. on 14.09.2023.
//

import SwiftUI

struct CleanerView<Content: View>: View {
    @Binding var backgroundAnimating: Bool
    let content: () -> Content

    var body: some View {
        ZStack {
            if backgroundAnimating {
                content()
            }
        }
        .background(BackgroundCleanerView())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation {
                    backgroundAnimating.toggle()
                }
            }
        }
    }
}
