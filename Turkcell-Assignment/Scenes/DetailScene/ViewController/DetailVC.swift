//
//  DetailVC.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView!{
        didSet{
            containerView.layer.cornerRadius = 16
            containerView.backgroundColor = .white
            containerView.layer.drawShadow(color: .black,
                                           alpha: 0.4,
                                           x: 0,
                                           y: 0,
                                           blur: 7,
                                           spread: 0)
        }
    }
    @IBOutlet private weak var imageView: UIImageView!{
        didSet{
            imageView.contentMode = .scaleAspectFit
            imageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet private weak var stackView: UIStackView!{
        didSet{
            stackView.alignment = .center
            stackView.distribution = .fillProportionally
            stackView.spacing = 10
        }
    }
    @IBOutlet private weak var labelName: UILabel!{
        didSet{
            labelName.font = .systemFont(ofSize: 18)
            labelName.textAlignment = .center
            labelName.numberOfLines = 1
            labelName.textColor = .black
        }
    }
    @IBOutlet private weak var labelPrice: UILabel!{
        didSet{
            labelPrice.font = .boldSystemFont(ofSize: 18)
            labelPrice.textAlignment = .center
            labelPrice.numberOfLines = 1
            labelPrice.textColor = .black
        }
    }
    @IBOutlet private weak var labelDescription: UILabel!{
        didSet{
            labelDescription.font = .systemFont(ofSize: 18)
            labelDescription.textAlignment = .center
            labelDescription.numberOfLines = 0
            labelDescription.textColor = .black
        }
    }
    
    // MARK: - Properties
    var viewModel: DetailVM = DetailVM()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        viewModel.delegate = self
        
        if let productId = self.data as? String {
            viewModel.fetchDetailService(productId: productId)
        }
    }
    
    // MARK: - Private method:
    private func configureUI() {
        navigationController?.isNavigationBarHidden = false
        view.backgroundColor = .white
        self.title = DetailSceneConstant.titleText
    }
    
    private func updateUI() {
        self.labelName.text = viewModel.name
        self.labelPrice.text = "Price: " + "\(viewModel.price)"
        self.labelDescription.text = viewModel.description
        self.imageView.cacheImage(urlString: viewModel.imageUrl)
    }
}

// MARK: - ViewModelDelegate
extension DetailVC: ViewModelDelegate {
    func failWith(error: String) {
        print("Error:", error)
    }
    
    func succes() {
        updateUI()
    }
}
