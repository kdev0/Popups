//
//  ModalTransitionView.swift
//
//  Created by Konstantin D. on 30.05.2023.
//

import SwiftUI

struct ModalTransitionView<Item, Content, Destination>: View where Item: Identifiable, Content: View, Destination: View {
	var item: Item
	var content: () -> Content
	var destination: (Item) -> Destination
	var transitionType: TransitionType

	init(item: Item,
		 transitionType: TransitionType,
		 content: @escaping () -> Content,
		 destination: @escaping (Item) -> Destination) {
		self.item = item
		self.transitionType = transitionType
		self.content = content
		self.destination = destination
	}

	var body: some View {
        self.destination(item)
            .transition(transitionType.transition)
	}
}

struct ModalTransitionViewModifier<Item, Destination>: ViewModifier where Item: Identifiable, Destination: View {
	var item: Item
	var transitionType: TransitionType
	var destination: (Item) -> Destination

	func body(content: Self.Content) -> some View {
		ModalTransitionView(item: item, transitionType: transitionType) {
			content
		} destination: { item in
			destination(item)
		}
	}
}
