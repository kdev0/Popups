//
//  TabView3.swift
//
//
//  Created by Konstantin D. on 20.06.2024.
//

import SwiftUI

struct TabView3: View {
    let onPopup: () -> Void

    var body: some View {
        VStack {
            HStack {
                ActivityIndicatorView()
                Text("Activity view 3")
            }
            .padding(20)

            Button {
                onPopup()
            } label: {
                Text("Show popup")
            }
        }
    }
}
