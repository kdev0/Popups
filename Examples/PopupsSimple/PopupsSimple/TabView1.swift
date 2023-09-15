//
//  TabView1.swift
//  PopupsSimple
//
//  Created by Konstantin D. on 13.09.2023.
//

import SwiftUI

struct TabView1: View {
    let onPopup: (Id) -> Void

    var body: some View {
        VStack {
            HStack {
                ActivityIndicatorView()
                Text("Activity view")
            }
            .padding(20)

            Button {
                onPopup(Id())
            } label: {
                Text("Show popup")
            }
        }
    }
}
