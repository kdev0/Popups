//
//  ModalTransitionType.swift
//
//  Created by Konstantin D. on 30.05.2023.
//

import SwiftUI

public protocol TransitionType {
	var transition: AnyTransition { get }
}

public enum ModalTransitionType {
	case opacity
	case fullScreen
}

extension ModalTransitionType: TransitionType {
	public var transition: AnyTransition {
		switch self {
		case .opacity:
			return .opacity
		case .fullScreen:
			return .move(edge: .bottom)
		}
	}
}
