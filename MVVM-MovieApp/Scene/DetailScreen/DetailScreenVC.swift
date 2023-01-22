//
//  DetailScreenVC.swift
//  MVVM-MovieApp
//
//  Created by Fatih on 22.01.2023.
//

import UIKit
protocol DetailScreenInterface: AnyObject {
    func configure()
    func configureElements()
    func configurePosterImage()
    func configureLabel()
}

class DetailScreenVC: UIViewController {
    private var posterImageView = UIImageView()
    private var imageTitle = UILabel()
    private var overview = UILabel()
    private var dateLabel = UILabel()
    private let movie: MovieResult
    private var dataTask: URLSessionDataTask!
    
    init(movie: MovieResult) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel = DetailScreenViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        
        
    }
 
}
extension DetailScreenVC: DetailScreenInterface {
    func configure() {
        view.backgroundColor = .white
    }
    func configureElements() {
        view.addSubview(posterImageView)
        posterImageView.backgroundColor = .red
        posterImageView.layer.cornerRadius = 15
        posterImageView.layer.masksToBounds = true
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.left.equalTo(view.snp.left).offset(10)
            make.width.equalTo(view.frame.size.width * 0.4)
            make.height.equalTo(view.frame.size.width * 0.6)
        }
    }
    func configurePosterImage() {
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
    func configureLabel() {
        imageTitle.text = movie.title
        imageTitle.font = .systemFont(ofSize: 16)
        imageTitle.textColor = .black
        view.addSubview(imageTitle)
        imageTitle.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.left.equalTo(posterImageView.snp.right).offset(20)
        }
        dateLabel.text = movie.releaseDate
        dateLabel.font = .systemFont(ofSize: 15)
        dateLabel.textColor = .black
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(imageTitle.snp.bottom).offset(25)
            make.left.equalTo(posterImageView.snp.right).offset(20)
        }
        overview.text = movie.overview
        overview.font = .systemFont(ofSize: 12)
        overview.numberOfLines = 0
        overview.textColor = .black
        view.addSubview(overview)
        overview.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(25)
            make.left.equalTo(posterImageView.snp.right).offset(20)
            make.width.equalTo(150)
        }
        
    }
    
    
}
