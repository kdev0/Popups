//
//  PopupModifier.swift
//  Popups
//
//  Created by Konstantin D. on 27.06.2023.
//

import SwiftUI

struct PopupModifier<Item: Identifiable, PopupContent: View>: ViewModifier {
    @Binding var item: Item?
    let popupContent: (Item) -> PopupContent

    @State private var offset: CGFloat = .zero
    @State private var contentHeight: CGFloat = .zero

    func body(content: Content) -> some View {
        content
            .fullScreenCover(item: $item, onDismiss: { $item.wrappedValue = nil }) { item in
                    Color.black
                        .opacity(0.1)
                        .ignoresSafeArea()
                        .onTapGesture(perform: dismiss)
                        .background(BackgroundCleanerView())
                        .transaction {
                            $0.disablesAnimations = false
                        }
                        .transition(.opacity)
                        .overlay(alignment: .bottom) {
                                PopupView(content: { popupContent(item) }, onClose: dismiss)
                                    .transition(.move(edge: .bottom))
                                    .offset(y: offset)
                                    .gesture(dragGesture())
                                    .readSize { size in
                                        contentHeight = size.height
                                    }
                        }

            }
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
    }
}

private extension PopupModifier {
    func dismiss() {
        withAnimation(.spring()) {
            offset = UIScreen.main.bounds.height
        }
        withTransaction(.init(animation: .easeInOut(duration: 3))) {
            item = nil
        }
        offset = .zero
    }

    func dragGesture() -> some Gesture {
        DragGesture()
            .onChanged { value in
                guard value.translation.height >= 0 else { return }
                offset = value.translation.height
            }
            .onEnded { value in
                if offset >= contentHeight * 0.3 {
                    dismiss()
                } else {
                    withAnimation(.spring()) {
                        offset = .zero
                    }
                }
            }
    }
}

public extension View {
    func popup<Item: Identifiable, Content: View>(item: Binding<Item?>,
                                                  @ViewBuilder content: @escaping ( Item ) -> Content) -> some View {
        modifier(PopupModifier(item: item, popupContent: content))
    }
}

struct BackgroundCleanerView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

extension View {
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
