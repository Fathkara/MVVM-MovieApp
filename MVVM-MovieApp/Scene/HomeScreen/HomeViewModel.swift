//
//  HomeViewModel.swift
//  MVVM-MovieApp
//
//  Created by Fatih on 22.01.2023.
//

import Foundation

protocol HomeViewModelInterface {
    var delegate: HomeScreenInterface? {get set}
    
    func viewDidLoad()
    func getMovies()
}

final class HomeViewModel {
    weak var delegate: HomeScreenInterface?
    private let service = MovieService()
    var movies: [MovieResult] = []
    private var page : Int = 1
}
extension HomeViewModel: HomeViewModelInterface {
    func viewDidLoad() {
        delegate?.configureVC()
        delegate?.configureCollectionView()
        getMovies()
    }
    func getMovies() {
        service.downloadMovies(page:page) { [weak self] returnedMovies in
            guard let strongSelf = self else {return}
            guard let returnedMovies = returnedMovies else {return}
            strongSelf.movies.append(contentsOf: returnedMovies)
            strongSelf.page += 1
            strongSelf.delegate?.reloadCollectionView()
        }
    }
    func getDetail(id:Int) {
        
        service.downloadDetail(id: id) { [weak self] returnDetail in
            guard let self = self else {return}
            guard let returnDetail = returnDetail else {return}
            self.delegate?.navigateToDetailScreen(movie: returnDetail)
            print(returnDetail)
        }
    }
    
    
}

