//
//  ContentView.swift
//  Shared
//
//  Created by Wouter Straver on 30/01/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Day 1") {
                    DayOneView()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
