//
//  DetailViewModel.swift
//  MVVM-MovieApp
//
//  Created by Fatih on 22.01.2023.
//

import Foundation
protocol DetailViewModelInterface {
    var delegate: DetailScreenInterface? {get set}
    func viewDidLoad()
    
}
class DetailScreenViewModel {
    weak var delegate: DetailScreenInterface?
}
extension DetailScreenViewModel: DetailViewModelInterface {
    func viewDidLoad() {
        delegate?.configure()
        delegate?.configureElements()
        delegate?.configurePosterImage()
        delegate?.configureLabel()
    }
}
