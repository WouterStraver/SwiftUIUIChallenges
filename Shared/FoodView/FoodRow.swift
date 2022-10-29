//
//  FoodRow.swift
//  SwiftUIUIChallenges
//
//  Created by Wouter Straver on 28/10/2022.
//

import SwiftUI

struct FoodRow: View {
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
                VStack(alignment:.leading, spacing:8) {
                    Text("Cream soup")
                        .font(.custom(Theme.poppins, size: 14))
                        .foregroundColor(.Theme.gray)
                    HStack {
                        Text("€4,50")
                            .font(.custom(Theme.poppinSemiBold, size: 14))
                            .foregroundColor(.Theme.orange)
                        Spacer()
                        Button(action:{}) {
                            Image(systemName: "plus")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.orange.cornerRadius(6))
                        }
                    }
                }
                .offset(y: -5)
                .padding(.horizontal, 12)
                .padding(.bottom, 10)
            }
        .background(Color(UIColor.systemBackground))
            .cornerRadius(12)
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

struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        FoodRow()
            .previewLayout(PreviewLayout.fixed(width: 300, height: 300))
    }
}

struct ImageMaskShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY)) //rigt upper corner.
        
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.8)) // let's go down to 90% .
        
        path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.maxY * 0.7), control: CGPoint(x: rect.maxX * 0.6, y: rect.maxY))
        
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        return path
    }
}
