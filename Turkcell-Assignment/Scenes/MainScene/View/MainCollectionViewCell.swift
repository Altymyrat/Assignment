//
//  MainCollectionViewCell.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 17.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var imageView: UIImageView!{
        didSet{
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet private weak var stackView: UIStackView!{
        didSet{
            stackView.alignment = .center
            stackView.distribution = .fillEqually
            stackView.spacing = 5
        }
    }
    @IBOutlet private weak var viewContanier: UIView! {
        didSet {
            viewContanier.layer.cornerRadius = 10
            viewContanier.backgroundColor = .white
            viewContanier.layer.drawShadow(color: .black,
                                           alpha: 0.4,
                                           x: 0,
                                           y: 0,
                                           blur: 7,
                                           spread: 0)
        }
    }
    @IBOutlet private weak var labelProductName: UILabel!{
        didSet{
            labelProductName.font = .systemFont(ofSize: 14)
            labelProductName.textAlignment = .center
            labelProductName.numberOfLines = 1
            labelProductName.textColor = .black
        }
    }
    @IBOutlet private weak var labelProductPrice: UILabel!{
        didSet{
            labelProductPrice.font = .boldSystemFont(ofSize: 14)
            labelProductPrice.textAlignment = .center
            labelProductPrice.numberOfLines = 1
            labelProductPrice.textColor = .black
        }
    }
    
    // MARK: - Properties
    var viewModel = DetailVM(){
        didSet{
            updateUI()
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: MainSceneConstant.cellIdentifier, bundle: nil )
    }
    
    // MARK: - Private method
    private func updateUI() {
        labelProductName.text = viewModel.name
        labelProductPrice.text = "Price: " + "\(viewModel.price)"
        imageView.cacheImage(urlString: viewModel.imageUrl)
    }
}
