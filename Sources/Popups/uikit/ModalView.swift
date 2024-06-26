//
//  ModalView.swift
//
//
//  Created by Konstantin D. on 07.11.2023.
//

import SwiftUI

struct ModalView<Item: Identifiable, ParentContent: View, ContentView: View>: View {
    @Binding var isPresented: Bool
    @Binding var item: Item?
    let onDismiss: (() -> Void)?
    let parentContent: ParentContent
    @ViewBuilder let content: ( Item ) -> ContentView

    @State private var parentViewController: UIViewController?
    @State private var currentViewController: UIViewController?

    var body: some View {
        parentContent
            .currentViewController { parentViewController = $0 }
            .onChange(of: isPresented) { _ in checkActionForViewState() }
            .onChange(of: item?.id) { _ in checkActionForViewState() }
            .onDisappear {
                dismissModalView()
                parentViewController = nil
            }
    }
}

private extension ModalView {
    func checkActionForViewState() {
        switch (isPresented, item, currentViewController) {
        case let (true, .some(item), nil):
            presentModalView(content: content(item), onDismiss: onDismiss)

        case let (true, .some(item), .some):
            dismissModalView {
                presentModalView(content: content(item), onDismiss: onDismiss)
            }

        case (false, _, .some), (_, nil, .some):
            dismissModalView()

        default: break
        }
    }

    func presentModalView(content: ContentView, onDismiss: (() -> Void)?) {
        let userDismissHandler = {
            isPresented = false
            item = nil
            onDismiss?()
        }

        let viewController = CustomHostingViewController(rootView: content,
                                                         onDismiss: userDismissHandler)
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        viewController.view.backgroundColor = .clear

        parentViewController?.present(viewController, animated: true)
        currentViewController = viewController
    }

    func dismissModalView(onDismiss: (() -> Void)? = nil) {
        currentViewController?.dismiss(animated: true, completion: onDismiss)
        currentViewController = nil
    }
}
