//
//  PopupView.swift
//  Popups
//
//  Created by Konstantin D. on 27.06.2023.
//

import SwiftUI

struct PopupView<Content: View>: View {
    private let content: Content
    private let onClose: () -> Void

    init(content: () -> Content, onClose: @escaping () -> Void) {
        self.content = content()
        self.onClose = onClose
    }

    var body: some View {
        VStack {
            content
                .frame(maxWidth: .infinity)
        }
        .background(Color.white.cornerRadius(20).ignoresSafeArea())
    }
}
