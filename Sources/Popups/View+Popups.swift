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
                         content: popupContainer)
    }
}
