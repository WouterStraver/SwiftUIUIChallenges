//
//  CategoryBarView.swift
//  SwiftUIUIChallenges
//
//  Created by Wouter Straver on 28/10/2022.
//

import SwiftUI

struct CategoryBarView: View {
    @Namespace var namespace
    @State private var selected: String = "Soup"
    let categories: [String] = ["All", "Soup", "Pizza", "Burger", "Salad", "Cupcakes", "Pasta", "Fish", "Meat"]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories, id:\.self) { category in
                    Button(action: {
                        withAnimation {
                            selected = category
                        }
                    }) {
                        Text(category)
                            .font(.custom(Theme.poppins, size: 14))
                            .foregroundColor(selected == category ? .Theme.orange : .Theme.lightGray)
                            .padding(.bottom, 4)
                            
                            .overlay(alignment:.bottomLeading) {
                                if selected == category {
                                    GeometryReader { geometry in
                                        VStack {
                                            Spacer()
                                            RoundedRectangle(cornerRadius: 5)
                                                .frame(width: geometry.size.width / 2, height: 2)
                                                .foregroundColor(.orange)
                                        }
                                    }
                                    .matchedGeometryEffect(id: "line", in: namespace)
                                }
                        }
                            
                    }
                }
            }
            .padding()
        }
    }
}

struct CategoryBarView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryBarView()
    }
}
