//
//  MovieHomeView.swift
//  SwiftUIUIChallenges (iOS)
//
//  Created by Wouter Straver on 07/04/2022.
//
// https://www.youtube.com/watch?v=GGYf8KrOQms -> 9 minuten.

import SwiftUI

struct MovieHomeView: View {
    // MARK: - Animated properties
    @State private var currentIndex: Int = 0
    @State private var currentTab = "Films"

    // Environment variables
    @Environment(\.colorScheme) var scheme
    @Namespace var animation

    var body: some View {
        ZStack {
            // BG
            bgView()

            // MARK: - Main View
            VStack {
                // Custom nav bar
                customNav()
                SnapCarousel(spacing: 20, tralingSpace: 150, index: $currentIndex, items: movies) { movie in
                    GeometryReader { geometry in
                        let size = geometry.size
                        Image(movie.artwork)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .cornerRadius(15)
                    }
                }
                .padding(.top, 70)

                // custom indicator
                customIndicator()

                HStack {
                    Text("Popular")
                        .font(.title3.bold())
                    Spacer()

                    Button(action: {}) {
                        Text("See more")
                            .font(.system(size: 16, weight: .semibold))
                    }
                }
                .padding()

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(movies) { movie in
                            Image(movie.artwork)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 120)
                                .cornerRadius(15)
                        }
                    }
                    .padding()

                }
            }

        }
    }

    // MARK: - Custom indiactor
    @ViewBuilder
    func customIndicator() -> some View {
        HStack(spacing: 5) {
            ForEach(movies.indices, id: \.self) { index in
                Circle()
                    .fill(currentIndex == index ? .blue : .gray.opacity(0.5))
                    .frame(width: currentIndex == index ? 10 : 6, height: currentIndex == index ? 10 : 6)
            }
        }
        .animation(.easeInOut, value: currentIndex)
    }

    @ViewBuilder
    func customNav() -> some View {
        HStack(spacing: 0) {
            ForEach(["Films", "Series"], id: \.self) { tab in
                Button(action: {
                    withAnimation {
                        currentTab = tab
                    }
                }) {
                    Text(tab)
                        .foregroundColor(.white)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 20)
                        .background {
                            if currentTab == tab {
                                Capsule()
                                    .fill(.regularMaterial)
                                    .environment(\.colorScheme, .dark)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                }
            }
        }
        .padding()
    }

    // MARK: - Blurry background
    @ViewBuilder
    func bgView() -> some View {
        GeometryReader { geometry in
            let size = geometry.size
            TabView(selection: $currentIndex) {
                ForEach(movies.indices, id: \.self) { index in
                    Image(movies[index].artwork)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .clipped()
                        .tag(index)
                }
            }
            #if os(iOS)
            .tabViewStyle(.page(indexDisplayMode: .never))
            #endif
            .animation(.easeInOut, value: currentIndex)

            let color: Color = scheme == .dark ? .black : .white

            // Gradient
            LinearGradient(
                colors: [
                    .black,
                    .clear,
                    color.opacity(0.15),
                    color.opacity(0.5),
                    color.opacity(0.8),
                    color,
                    color
                ],
                startPoint: .top, endPoint: .bottom)

            // Blurred overlay
            Rectangle()
                .fill(.ultraThinMaterial)

        }
        .ignoresSafeArea()
    }
}

struct MovieHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieHomeView()
        }
    }
}
