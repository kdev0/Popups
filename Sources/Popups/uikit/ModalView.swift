//
//  ModalView.swift
//
//
//  Created by Konstantin D. on 07.11.2023.
//

import SwiftUI

struct ModalView<Item: Identifiable, ContentView: View>: View {
    @Binding var isPresented: Bool
    @Binding var item: Item?
    let onDismiss: (() -> Void)?
    @ViewBuilder let content: ( Item ) -> ContentView
    
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}
