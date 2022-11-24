//
//  FoodDetailView.swift
//  SwiftUIUIChallenges
//
//  Created by Wouter Straver on 23/11/2022.
//

import SwiftUI

struct FoodDetailView: View {
    @State private var size: CGFloat = .zero
    
    var body: some View {
        VStack(spacing:0) {
            Image("pumpkinsoup")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .mask(ImageMaskShape())
                .contentShape(Rectangle())// Dit is dus nodig om het niet clickbaar te maken boven de image. Vrij apart maarja.
                .clipped()
            VStack(alignment:.leading, spacing: 12) {
                Text("Cream Soup")
                    .displaySmall(.semibold)
                    .foregroundColor(.black.opacity(0.8))
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
                .bodyLarge()
                .opacity(0.7)
                .foregroundColor(.Theme.gray)
            }
            .padding(.horizontal)
            .offset(y: -30)
            
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
                RoundedRectangle(cornerRadius:12) .strokeBorder(Color.Theme.lightGray.opacity(0.3), lineWidth: 1)
            )
            .padding()
            
            Spacer()
        }
        .ignoresSafeArea()
        .background(Color.systemBackground)
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
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView()
    }
}

private struct Element: View {
    let title: String
    let value: String
    var body: some View {
        VStack(spacing:4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.Theme.lightGray)
            Text(value)
                .foregroundColor(.Theme.green)
                .font(.callout)
                .bold()
        }
    }
}
