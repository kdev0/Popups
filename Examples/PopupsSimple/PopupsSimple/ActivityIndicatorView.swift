//
//  ActivityIndicatorView.swift
//  PopupsSimple
//
//  Created by Konstantin D. on 13.09.2023.
//

import SwiftUI

struct ActivityIndicatorView: View {
    let size: CGSize

    init(size: CGSize = CGSize(width: 24, height: 24)) {
        self.size = size
    }

    var body: some View {
        CircleActivityIndicatorView()
            .foregroundColor( .blue )
            .frame(width: size.width, height: size.height)
    }
}

struct CircleActivityIndicatorView: View {

    @State private var trimFrom: Double = 0.3
    @State private var rotation: Double = 0
    @State private var rotation2: Double = 0

    let mainDuration: TimeInterval = 0.75

    var body: some View {

        let animation = Animation.timingCurve(
            0.4, 0.1, 0.25, 0.9,
            duration: mainDuration
        )

        Circle()
            .trim( from: trimFrom, to: 1 )
            .stroke(
                style: StrokeStyle( lineWidth: 3, lineCap: .round )
            )
            .animation(
                animation.repeatForever( autoreverses: true ),
                value: trimFrom
            )

            .rotationEffect( .degrees( rotation ))
            .animation(
                animation.delay( mainDuration ).repeatForever( autoreverses: false ),
                value: rotation
            )

            .rotationEffect( .degrees( rotation2 ))
            .animation(
                .linear( duration: 2 ).repeatForever( autoreverses: false ),
                value: rotation2
            )
            .onAppear{
                DispatchQueue.main.async {
                    rotation = 360
                    trimFrom = 1
                    rotation2 = 360
                }
            }
    }
}
