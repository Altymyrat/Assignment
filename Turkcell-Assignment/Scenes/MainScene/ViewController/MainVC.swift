//
//  MainVC.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet{
            let layout = UICollectionViewFlowLayout()
            collectionView.collectionViewLayout = layout
            layout.itemSize = CGSize(width: 120, height: 120)
            collectionView.register(MainCollectionViewCell.nib(), forCellWithReuseIdentifier: MainSceneConstant.cellIdentifier)
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsVerticalScrollIndicator = false
            collectionView.backgroundColor = .clear
        }
    }
    
    // MARK: - Properties
    private var viewModel = MainVM()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchProductService()
        self.title = MainSceneConstant.titleText
    }
}

// MARK: -
extension MainVC: ViewModelDelegate {
    func failWith(error: String) {
        print("Error: ", error)
    }
    
    func succes() {
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate
extension MainVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let viewController = ViewControllerBuilder.make(with: .detail)
        viewController.data = viewModel.getProductItem(at: indexPath.row).productId
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UICollectionViewDataSource
extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.listCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainSceneConstant.cellIdentifier, for: indexPath) as! MainCollectionViewCell
        cell.viewModel = viewModel.getProductItem(at: indexPath.row)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let size = self.collectionView.frame.width/2 - 10
        return CGSize(width: size, height: size)
    }
}
