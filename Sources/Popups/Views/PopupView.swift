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
    }
}

extension PopupView {
    struct RoundedCorner: Shape {
        var radius: CGFloat = .infinity
        var corners: UIRectCorner = .allCorners

        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }
}
