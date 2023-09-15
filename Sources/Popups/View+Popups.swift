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

        return fullScreenCover(item: item, onDismiss: dismiss) { item in
            PopupContainerView(item: item,
                               popupContent: content,
                               dismiss: dismiss)
        }
    }
}
