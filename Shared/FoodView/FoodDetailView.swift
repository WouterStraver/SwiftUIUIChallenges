//
//  FoodDetailView.swift
//  SwiftUIUIChallenges
//
//  Created by Wouter Straver on 23/11/2022.
//

import SwiftUI

struct FoodDetailView: View {
    @State private var size: CGFloat = .zero
    @State private var showIndex = 0
    @Binding var showDetail: Bool
    @State var scrollOffset: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            ObservableScrollView(scrollOffset: $scrollOffset) { _ in
                VStack(spacing:0) {
                    Image("pumpkinsoup")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size, height: size)
                        .mask(ImageMaskShape())
                        .contentShape(Rectangle())// Dit is dus nodig om het niet clickbaar te maken boven de image. Vrij apart maarja.
                        .clipped()
                        .opacityOffset($showIndex, triggerIndex: 1, offsetY: 100)
                        .offset(y: scrollOffset > 0 ? 0 : scrollOffset)
                        .scaleEffect(scrollOffset < 0 ? (-scrollOffset / 300) + 1 : 1)
                       
                    
                    VStack(alignment:.leading, spacing: 16) {
                        header
                        extraInfo
                            .opacityOffset($showIndex, triggerIndex: 2, offsetY: 150)
                        
                        Text("This is our new super soup, which is delicious even when cold. Don't miss the oppurtinuity to try! SuperOOUP!")
                            .foregroundColor(.Theme.gray)
                            .bodyLarge(.light)
                            .lineSpacing(2)
                            .opacityOffset($showIndex, triggerIndex: 3, offsetY: 200)
                        
                        Text("It tastes better together!")
                            .titleLarge(.semibold)
                            .foregroundColor(.primary.opacity(0.8))
                            .opacityOffset($showIndex, triggerIndex: 4, offsetY: 150)
                    }
                    .padding(.horizontal)
                    .offset(y: -30)
                    Spacer()
                }
                .ignoresSafeArea()
                .shadow(color: Color.black.opacity(0.1), radius: 2, x: 1, y: 1)
                .overlay {
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                size = geometry.size.width
                            }
                            .onChange(of: geometry.size.width) { newValue in
                                size = newValue
                            }
                    }
                }
                .offset(y: -geometry.safeAreaInsets.top)
            }
            .coordinateSpace(name: "scroll")
            .background(Color.systemBackground.opacity(showIndex > 0 ? 1 : 0))
            .safeAreaInset(edge: .bottom) {
                bottomButton
                    .opacityOffset($showIndex, triggerIndex: 6, offsetY: 200)
            }
            .onAppear {
                for index in 0...7 {
                    withAnimation(.easeInOut(duration: 0.3 + (Double(index) * 0.1)).delay(Double(index) * 0.1)){
                        showIndex += 1
                    }
                }
            }
        }
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView(showDetail: .constant(true))
    }
}

extension FoodDetailView {
    private var bottomButton: some View {
        Button(action: {
            showDetail = false
        }) {
            HStack {
                Text("Add to order")
                Spacer()
                Text("€4,50")
            }
            .titleMedium(.semibold)
            .foregroundColor(.systemBackground)
            .padding()
            .frame(height:50)
            .background(Color.Theme.orange)
            .cornerRadius(12)
        }
        .padding()
        .background(.ultraThickMaterial)
    }
    
    private var header: some View {
        Group {
            Text("Cream Soup")
                .displaySmall(.semibold)
                .foregroundColor(.black.opacity(0.8))
                .opacityOffset($showIndex, triggerIndex: 1, offsetY: 100)
            AdaptiveView(.horizontal, showsIndicators: false) {
                HStack {
                    Text("Allergen-free")
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundColor(.Theme.green)
                    Text("Allergen-free")
                    Circle()
                        .frame(width: 5, height: 5)
                        .foregroundColor(.Theme.green)
                    Text("Allergen-free")
                    Spacer()
                    
                }
                .bodyMedium()
            }
            .foregroundColor(.Theme.text)
            .opacityOffset($showIndex, triggerIndex: 2, offsetY: 150)
        }
    }
    
    private var extraInfo: some View {
        HStack {
            Element(title: "Weight", value: "350 g.")
            Spacer()
            Element(title: "Calories", value: "340 g.")
            Spacer()
            Element(title: "Protein", value: "40 g.")
        }
        .padding()
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius:12) .strokeBorder(Color.Theme.green.opacity(0.4), lineWidth: 0.5)
        )
    }
}

private struct Element: View {
    let title: String
    let value: String
    var body: some View {
        VStack(spacing:4) {
            Text(title)
                .foregroundColor(.Theme.text)
                .titleSmall(.light)
            Text(value)
                .foregroundColor(.Theme.green)
                .titleMedium(.semibold)
        }
    }
}


struct OpacityOffsetModifier: ViewModifier {
    @Binding var currentIndex: Int
    let triggerIndex: Int
    let offsetY: CGFloat
    func body(content: Content) -> some View {
        content
            .opacity(currentIndex > triggerIndex ? 1 : 0)
            .offset(y: currentIndex > triggerIndex ? 0 : offsetY)
    }
}

extension View {
    func opacityOffset(_ currentIndex: Binding<Int>, triggerIndex: Int, offsetY: CGFloat) -> some View {
        return self.modifier(OpacityOffsetModifier(currentIndex: currentIndex, triggerIndex: triggerIndex, offsetY: offsetY))
    }
}
