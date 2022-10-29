//
//  SnapCarosel.swift
//  SwiftUIUIChallenges (iOS)
//
//  Created by Wouter Straver on 07/04/2022.
//

import Foundation
import SwiftUI

struct SnapCarousel<Content: View, T: Identifiable>: View {
    var content: (T) -> Content
    var list: [T]

    var spacing: CGFloat
    var tralingSpace: CGFloat
    @Binding var index: Int

    init(spacing: CGFloat = 15, tralingSpace: CGFloat = 100, index: Binding<Int>, items: [T], @ViewBuilder content: @escaping (T) -> Content) {
        self.list = items
        self.spacing = spacing
        self.tralingSpace = tralingSpace
        self._index = index
        self.content = content
    }

    @GestureState var offset: CGFloat = 0
    @State var currentIndex = 0

    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width - (tralingSpace - spacing)
            let adjustMenthWidth = (tralingSpace / 2) - spacing
            HStack(spacing: spacing) {
                ForEach(list) { item in
                    content(item)
                        .frame(width: geometry.size.width - tralingSpace)
                        .offset(y: getOffset(item: item, width: width))
                }
            }
            .padding(.horizontal, spacing)
            .offset(x: (CGFloat(currentIndex) * -width) + ( currentIndex != 0 ? adjustMenthWidth : 0) + offset)
            .gesture(
                DragGesture()
                    .updating($offset, body: { value, out, _ in
                        // making it slower. 
                        out = (value.translation.width / 1.5)
                    })
                    .onEnded({ value in
                        // hoeveel beweeg je
                        let offsetX = value.translation.width
                        // omrekenen naar een getal tussen -1 en 1
                        // Gebruik -offsetX omdat swipen naar links zorgt voor een min getal en je wilt het precies andersom.
                        let progress = -offsetX / width
                        // vervolgens afronden naar dichtsbijzijnde, dus of -1 of 0 of 1.
                        let roudProgress = progress.rounded()
                        // Dan daar naar toe verplaatsen.
                        currentIndex = max(min(currentIndex + Int(roudProgress), list.count - 1), 0)

                        currentIndex = index
                    })
                    .onChanged({ value in
                        // hoeveel beweeg je
                        let offsetX = value.translation.width
                        // omrekenen naar een getal tussen -1 en 1
                        // Gebruik -offsetX omdat swipen naar links zorgt voor een min getal en je wilt het precies andersom.
                        let progress = -offsetX / width
                        // vervolgens afronden naar dichtsbijzijnde, dus of -1 of 0 of 1.
                        let roudProgress = progress.rounded()
                        // Dan daar naar toe verplaatsen.
                        index = max(min(currentIndex + Int(roudProgress), list.count - 1), 0)
                    })
            )
        }
        .animation(.easeInOut, value: offset == 0)
    }

    func getOffset(item: T, width: CGFloat) -> CGFloat {
        // progress
        let progress = ((offset < 0 ? offset : -offset) / width) * 60

        let topOffset = -progress < 60 ? progress : -(progress + 120)

        let previous = getIndex(item: item) - 1 == currentIndex ? (offset < 0 ? topOffset : -topOffset) : 0

        let next = getIndex(item: item) + 1 == currentIndex ? (offset < 0 ? -topOffset : topOffset) : 0

        // safety check
        let checkBetween = currentIndex >= 0 && currentIndex < list.count ? ( getIndex(item: item) - 1 == currentIndex ? previous : next ) : 0

        return getIndex(item: item) == currentIndex ? -60 - topOffset : checkBetween
    }

    func getIndex(item: T) -> Int {
        return list.firstIndex(where: {$0.id == item.id}) ?? 0
    }

}

struct SnapCarousel_Previews: PreviewProvider {
    static var previews: some View {
        MovieHomeView()
    }
}
