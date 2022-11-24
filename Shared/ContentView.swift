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
                    Text("Movies")
                }
                NavigationLink(destination: FoodMainView().toolbar(.hidden)) {
                    Text("Food view")
                }
                NavigationLink(destination: TestAdaptiveView()) {
                    Text("Adaptive View")
                }
                NavigationLink(destination: TagView()) {
                    Text("TagView")
                }
                NavigationLink(destination: TestCompositionalView()) {
                    Text("CompositionalView")
                }
                NavigationLink(destination: CustomLayoutView()) {
                    Text("CustomLayout view")
                }
            }
            .navigationDestination(for: String.self, destination: { _ in
                MovieHomeView()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
