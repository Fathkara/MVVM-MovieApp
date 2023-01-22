//
//  Movie.swift
//  MVVM-MovieApp
//
//  Created by Fatih on 22.01.2023.
//

import Foundation

struct Movie: Decodable {
    let results: [MovieResult]?
}

struct MovieResult:Decodable {
    let id: Int?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let title: String?
    
    enum CodingKeys: String,CodingKey {
        case posterPath = "poster_path"
        case id
        case overview,title
        case releaseDate = "release_date"
    }
    
}





