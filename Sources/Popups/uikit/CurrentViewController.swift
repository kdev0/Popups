//
//  CurrentViewController.swift
//
//
//  Created by Konstantin D. on 08.11.2023.
//

import SwiftUI
import UIKit

struct CurrentViewController: UIViewControllerRepresentable {
    let onSetting: (UIViewController) -> Void

    func makeUIViewController(context: Context) -> some UIViewController {
        let viewController = UIViewController()

        viewController.view = CurrentView {
            var responder = viewController.view.next?.next
            while  responder != nil {
                if let controller = responder as? UIViewController {
                    DispatchQueue.main.async {
                        onSetting(controller)
                    }
                }
            }
        }

        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

class CurrentView: UIView {
    let onSetting:() -> Void

    init(onSetting: @escaping () -> Void) {
        self.onSetting = onSetting

        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToWindow() {
        onSetting()
    }
}
