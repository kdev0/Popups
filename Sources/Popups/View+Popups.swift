//
//  View+Popups.swift
//  
//
//  Created by Konstantin D. on 14.09.2023.
//

import SwiftUI

public extension View {
    func popup<Item: Identifiable, Content: View>(item: Binding<Item?>,
                                                  @ViewBuilder content: @escaping ( Item ) -> Content) -> some View {
        let dismiss = {
            item.wrappedValue = nil
        }

        @ViewBuilder
        func popupContainer(item: Item) -> some View {
            PopupContainerView(item: item,
                               popupContent: content,
                               dismiss: dismiss)
        }

        return ModalView(isPresented: .constant(true),
                         item: item,
                         onDismiss: dismiss,
                         parentContent: self,
                         content: popupContainer)
    }

    func modalTransition<Item: Identifiable, Destination: View>(item: Binding<Item?>,
                                                                 transitionType: TransitionType,
                                                                 destination: @escaping (Item) -> Destination) -> some View {
        let dismiss = {
            item.wrappedValue = nil
        }

        @ViewBuilder
        func popupContainer(item: Item) -> some View {
            self.modifier(ModalTransitionViewModifier(item: item,
                                                      transitionType: transitionType,
                                                      destination: destination))
        }
        return ModalView(isPresented: .constant(true),
                         item: item,
                         onDismiss: dismiss,
                         parentContent: self,
                         content: popupContainer)
    }

}
