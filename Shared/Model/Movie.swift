//
//  Movie.swift
//  SwiftUIUIChallenges (iOS)
//
//  Created by Wouter Straver on 07/04/2022.
//

import Foundation
struct Movie: Identifiable {
    let id = UUID().uuidString
    let artwork: String
    let title: String
}

var movies = [
    Movie(artwork: "fastfurious", title: "Furious 7"),
    Movie(artwork: "harrypotter", title: "Harry Potter"),
    Movie(artwork: "lordoftherings", title: "Lord of the Rings"),
    Movie(artwork: "spiderman", title: "Spiderman")

]
