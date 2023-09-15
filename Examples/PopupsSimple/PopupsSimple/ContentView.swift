//
//  ContentView.swift
//  PopupsSimple
//
//  Created by Konstantin D. on 13.09.2023.
//

import SwiftUI
import Popups

struct ContentView: View {
    @State var showPopups: Id?

    var body: some View {
        TabView {
            TabView1 { showPopups = $0 }
                .tabItem {
                    Label("Menu", systemImage: "list.dash")
                }
            TabView2()
                .tabItem {
                    Label("Order", systemImage: "square.and.pencil")
                }
        }
        .popup(item: $showPopups) { id in
            TabView2()
                .frame(height: 400)
        }
    }
}


struct Id: Identifiable {
    let id = UUID()
}
