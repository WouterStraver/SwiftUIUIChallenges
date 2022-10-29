//
//  ContentView.swift
//  Shared
//
//  Created by Wouter Straver on 30/01/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: MovieHomeView()) {
                    Text("Day 1")
                }
                NavigationLink(value: "Hi") {
                    Text("Hi")
                }
                NavigationLink(destination: FoodMainView().toolbar(.hidden)) {
                    Text("Food view")
                }
                NavigationLink(destination: TestAdaptiveView()) {
                    Text("Adaptive View")
                }
            }
            .navigationDestination(for: String.self, destination: { _ in
                MovieHomeView()
            })
        }
//        NavigationView {
//            List {
//                NavigationLink("Day 1") {
//                    MovieHomeView()
//                }
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
