//
//  PopupContainerView.swift
//  Popups
//
//  Created by Konstantin D. on 27.06.2023.
//

import SwiftUI

struct PopupContainerView<Item: Identifiable, PopupContent: View>: View {
    let item: Item
    let popupContent: (Item) -> PopupContent
    let dismiss: () -> Void

    @GestureState private var dragOffset: CGFloat = .zero
    @State private var contentHeight: CGFloat = .zero
    @State private var contentAnimating = false

    var body: some View {
        BackgroundView(onTap: close)
            .overlay(alignment: .bottom) {
                if contentAnimating {
                    PopupView(content: { popupContent(item) }, onClose: dismiss)
                        .transition(.move(edge: .bottom))
                        .offset(y: dragOffset)
                        .readSize { contentHeight = $0.height }
                        .gesture(dragGesture())
                        .animation(.spring(), value: dragOffset)
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring()) {
                        contentAnimating.toggle()
                    }
                }
            }
    }
}

private extension PopupContainerView {
    func close() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            withAnimation(.spring()) {
                contentAnimating.toggle()
            }
            dismiss()
        }
    }

    func dragGesture() -> some Gesture {
        DragGesture()
            .updating($dragOffset) { value, state, _ in
                guard value.translation.height >= .zero else { return }

                state = value.translation.height
            }
            .onEnded { value in
                if value.translation.height >= contentHeight * 0.5 {
                    close()
                }
            }
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

private extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}
