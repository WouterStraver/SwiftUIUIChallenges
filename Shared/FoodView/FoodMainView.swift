//
//  FoodMainView.swift
//  SwiftUIUIChallenges (iOS)
//
//  Created by Wouter Straver on 04/10/2022.
//

// https://dribbble.com/shots/17999349-Food-Market-App

import SwiftUI

struct FoodMainView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchString = ""
    @State var startingAnimation = false
    @State private var animationIndex = 0
    
    var body: some View {
        VStack {
            navButtons
            ScrollView {
                VStack {
                    header
                    LazyVStack(pinnedViews: .sectionHeaders) {
                        Section {
                            CustomLayout(spacing: 24) {
                                FoodRow()
                                    .offset(y: animationIndex > 0 ? 0 : 150)
                                    .opacity(animationIndex > 0 ? 1 : 0)
                                Rectangle()
                                    .frame(height: 150)
                                    .foregroundColor(.clear)
                                    .background(Color(uiColor: UIColor().hexStringToUIColor(hex: "#84CB83")).gradient)
                                    .cornerRadius(12)
                                    .overlay(alignment: .bottomTrailing, content: {
                                        GeometryReader { geometry in
                                            Image("salad")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottomTrailing)
                                                .position(x: geometry.size.width - geometry.size.width * 0.2, y: geometry.size.height - geometry.size.height * 0.2)
                                                .clipped()
                                        }
                                    })
                                    .overlay(alignment:.topLeading) {
                                        Text("New\nSalad!")
                                            .font(.title2)
                                            .foregroundColor(.white)
                                            .bold()
                                            .padding()
                                    }
                                    .offset(y: animationIndex > 1 ? 0 : 150)
                                    .opacity(animationIndex > 1 ? 1 : 0)
                                ForEach(0...5, id:\.self) { index in
                                    FoodRow()
                                        .offset(y: animationIndex > index + 2 ? 0 : (150 + 70 * Double(index)))
                                        .opacity(animationIndex > index + 2 ? 1 : 0)
                                }
                            }
                        } header: {
                            CategoryBarView()
                                .background(Color(UIColor.systemBackground))
                        }
                    }
                    .listStyle(.plain)
                    .padding(.horizontal)
                }
            }.onAppear {
                startingAnimation = true
                for index in 0...7 {
                    withAnimation(.easeInOut(duration: 1.2).delay(Double(index) * 0.1)){
                        animationIndex += 1
                    }
                }
            }
        }
    }
}

struct FoodMainView_Previews: PreviewProvider {
    static var previews: some View {
        FoodMainView()
    }
}

extension FoodMainView {
    
    private var header: some View {
        VStack(alignment:.leading) {
            Text("Hi, Wouter 👋")
                .offset(x: startingAnimation ? 0 : -400)
                .animation(.default.speed(0.5), value: startingAnimation)
            Text("Try our new dishes today!")
                .offset(x: startingAnimation ? 0 : -400)
                .animation(.default.speed(0.5), value: startingAnimation)
            HStack(spacing:8) {
                TextField("", text: $searchString)
                    .font(.custom(Theme.poppins, size: 14))
                    .padding(8)
                    .frame(height:40)
                    .padding(.leading, 40)
                    .background(
                        Color(UIColor().hexStringToUIColor(hex: "#f9f9f9"))
                            .cornerRadius(12)
                    )
                    .overlay(alignment: .leading) {
                        Image(systemName: "magnifyingglass")
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)
                    }
                
                Button(action:{}) {
                    Image(systemName: "slider.horizontal.3")
                        .fontWeight(.light)
                        .foregroundColor(Color.Theme.orange)
                        .frame(width: 40, height: 40)
                        .background(
                            Color.white
                                .cornerRadius(6)
                                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
                        )
                }
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .font(.custom(Theme.poppinSemiBold, size: 20))
    }
    
    private var navButtons: some View {
        HStack {
            Button(action: {dismiss()}) {
                VStack(alignment:.leading, spacing:3) {
                    RoundedRectangle(cornerRadius: 3)
                        .frame(width:13, height: 2)
                    RoundedRectangle(cornerRadius: 3)
                        .frame(width:18, height: 2)
                    RoundedRectangle(cornerRadius: 3)
                        .frame(width:12, height: 2)
                }
                .foregroundColor(.black)
            }
            Spacer()
            Button(action:{}) {
                Image(systemName: "bell")
                    .fontWeight(.light)
                    .foregroundColor(Color.Theme.orange)
                    .frame(width: 40, height: 40)
                    .background(
                        Color.white
                            .cornerRadius(6)
                            .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 1)
                    )
            }
        }
        .padding(.horizontal)
    }
}
