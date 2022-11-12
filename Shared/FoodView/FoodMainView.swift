//
//  FoodMainView.swift
//  SwiftUIUIChallenges (iOS)
//
//  Created by Wouter Straver on 04/10/2022.
//

// https://dribbble.com/shots/17999349-Food-Market-App

import SwiftUI

struct FoodMainView: View {
    @State private var searchString = ""
    var body: some View {
        VStack {
            navButtons
            ScrollView {
                VStack {
                    header
//                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 160))], spacing: 16, pinnedViews: [.sectionHeaders]) {
//
//                        Section {
//                            ForEach(0...5, id:\.self) { _ in
//                                FoodRow()
//                                    .padding(.horizontal, 8)
//                            }
//                        } header: {
//                            CategoryBarView()
//                                .background(Color(UIColor.systemBackground))
//                        }
//                    }
//                    .listStyle(.plain)
//                    .padding(.horizontal)
                    CustomLayout(spacing: 24) {
                        FoodRow()
                        Rectangle()
                            .frame(height: 150)
                            .foregroundColor(.red)
                            .cornerRadius(12)
                        ForEach(0...5, id:\.self) { _ in
                            FoodRow()
                        }
                        
                        
                    }
                    .padding()
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
            Text("Hi, Martina 👋")
            Text("Try our new dishes today!")
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
            Button(action: {}) {
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
