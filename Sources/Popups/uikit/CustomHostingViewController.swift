//
//  CustomHostingViewController.swift
//
//
//  Created by Konstantin D. on 07.11.2023.
//

import UIKit
import SwiftUI

final class CustomHostingViewController<ViewType: View>: UIHostingController<ViewType>, UIAdaptivePresentationControllerDelegate {
    let onDismiss: (() -> Void)?

    init( rootView: ViewType, onDismiss: (() -> Void)? ) {
        self.onDismiss = onDismiss
        super.init( rootView: rootView )
    }
    
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentationController?.delegate = self
    }

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        onDismiss?()
    }
}
