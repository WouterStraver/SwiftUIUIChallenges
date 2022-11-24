//
//  AdaptiveView.swift
//  SwiftUIUIChallenges
//
//  Created by Wouter Straver on 29/10/2022.
//

import SwiftUI

struct AdaptiveView<Content: View>: View  {
    var content: Content
    var axis: Axis.Set
    var showIndicators: Bool
    init(_ axis: Axis.Set = .vertical, showsIndicators: Bool = true, @ViewBuilder content: @escaping() -> Content) {
        self.axis = axis
        self.showIndicators = showsIndicators
        self.content = content()
    }
    
    var body: some View {
        ViewThatFits {
            content
            ScrollView(axis,showsIndicators: showIndicators) {
                content
            }
        }
        .navigationTitle("AdaptiveView")
    }
}

struct TestAdaptiveView: View {
    @State var objectCount: Int = 1
    
    var body: some View {
        AdaptiveView {
            VStack(spacing: 10) {
                ForEach(1...objectCount, id:\.self) { index in
                    Rectangle()
                        .fill(.red)
                        .frame(height: 200)
                        .onTapGesture {
                            objectCount += 1
                        }
                }
            }
        }
    }
}

struct TestAdaptiveView_Previews: PreviewProvider {
    static var previews: some View {
        TestAdaptiveView()
    }
}
