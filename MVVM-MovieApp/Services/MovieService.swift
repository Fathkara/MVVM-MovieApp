//
//  MovieService.swift
//  MVVM-MovieApp
//
//  Created by Fatih on 22.01.2023.
//

import Foundation

struct Constants {
    static let Api_Key = "7449b8e0901923de98300585d22d2be7"
    static let Api_URL = "https://api.themoviedb.org"
}
enum DetailConstants {
    static func movies(page:Int) -> String{
        "\(Constants.Api_URL)/3/movie/popular?api_key=\(Constants.Api_Key)&language=en-US&page=\(page)"
    }
    static func images(posterPath:String) -> String {
        "https://image.tmdb.org/t/p/w500\(posterPath)"
    }
    static func detail(id:Int) -> String {
        "https://api.themoviedb.org/3/movie/\(id)?api_key=\(Constants.Api_Key)&language=en-US&language=en-US&page"
    }
}
class MovieService {
    func downloadMovies(page: Int , completion: @escaping ([MovieResult]?)->()) {
        guard let url = URL(string: DetailConstants.movies(page: page)) else {return}
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else {return}
            switch result {
                
            case .success(let data):
                completion(self.handleWithData(data: data))
            case .failure(let error):
                self.handleWithError(error: error)
            }
        }
    }
    
    func downloadDetail(id: Int, completion: @escaping(MovieResult?)->() ) {
        guard let url = URL(string: DetailConstants.detail(id: id)) else {return}
        NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case.success(let data):
                completion(self.handleWithDetailData(data: data))
            case.failure(let error):
                self.handleWithError(error: error)
            }
            
        }
    }
    
    private func handleWithError(error:Error) {
        print(error.localizedDescription)
    }
    private func handleWithData(data:Data) -> [MovieResult]? {
        do {
            let movie = try JSONDecoder().decode(Movie.self, from: data)
            return movie.results
        } catch  {
            print(error)
        }
        return nil
    }
    private func handleWithDetailData(data:Data) -> MovieResult? {
        do {
            let detailMovie = try JSONDecoder().decode(MovieResult.self, from: data)
            return detailMovie
        } catch  {
            print(error)
            return nil
        }
    }
}
