//
//  CustomHostingViewController.swift
//
//
//  Created by Konstantin D. on 07.11.2023.
//

import UIKit
import SwiftUI

final class CustomHostingViewController<ViewType: View>: UIHostingController {
    let onDismiss: (() -> Void)?

    init( rootView: V, onDismiss: (() -> Void)? ) {
        self.onDismiss = onDismiss
        super.init( rootView: rootView )
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presentationController?.delegate = self
    }
}

extension CustomHostingViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        onDismiss?()
    }
}
