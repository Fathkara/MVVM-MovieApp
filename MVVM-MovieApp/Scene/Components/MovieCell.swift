//
//  MovieCell.swift
//  MVVM-MovieApp
//
//  Created by Fatih on 22.01.2023.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    static let identifier = "MovieCell"
    lazy var posterImageView = UIImageView()
    var dataTask: URLSessionDataTask!
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func downloadImage(movie: MovieResult) {
        
        guard let url = URL(string: DetailConstants.images(posterPath: movie.posterPath!)) else {return}
            dataTask = NetworkManager.shared.download(url: url) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case.success(let data):
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                }
            case.failure(let error):
                print(error)
            }
        }
        dataTask.resume()
    }
    func cancelDownloading() {
        dataTask.cancel()
        dataTask = nil
    }
    override func prepareForReuse() {
        posterImageView.image = nil
        cancelDownloading()
    }
    func configureCell() {
        backgroundColor = .systemGray4
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
    func configureImage() {
        addSubview(posterImageView)
        posterImageView.layer.masksToBounds = true
        posterImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
}
