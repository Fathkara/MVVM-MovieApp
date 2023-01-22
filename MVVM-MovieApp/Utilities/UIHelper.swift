//
//  UIHelper.swift
//  MVVM-MovieApp
//
//  Created by Fatih on 22.01.2023.
//


import UIKit
enum UIHelper {
    static func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: CGFloat.screenWidth, height: CGFloat.screenWidth * 1.5)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 30
        return layout
    }
}

