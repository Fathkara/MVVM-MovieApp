//
//  HomeScreenVC.swift
//  MVVM-MovieApp
//
//  Created by Fatih on 22.01.2023.
//

import UIKit
import SnapKit
protocol HomeScreenInterface: AnyObject {
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()
    func navigateToDetailScreen(movie: MovieResult)
}
class HomeScreenVC: UIViewController {

    private let viewModel = HomeViewModel()
    private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
}
extension HomeScreenVC: HomeScreenInterface {
    func configureVC() {
        view.backgroundColor = .systemBackground
        title = "Popular Movies"
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: UIHelper.createFlowLayout())
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    func navigateToDetailScreen(movie: MovieResult) {
        DispatchQueue.main.async {
            let detailVC = DetailScreenVC(movie: movie)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
extension HomeScreenVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            return UICollectionViewCell()
        }
        cell.downloadImage(movie: viewModel.movies[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(id: viewModel.movies[indexPath.item].id!)
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        if offsetY >= contentHeight-(height * 2) {
            viewModel.getMovies()
        }
    }
}
