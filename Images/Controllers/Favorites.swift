//
//  Favorites.swift
//  Images
//
//  Created by Alice Romanova on 06.06.2022.
//

import UIKit

final class Favorites: UIViewController {
    
    var favoritesImages = [PictureParametets]()
    var favoritesCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        setupFavoritesCollectionView()
        
    }
    
    private func setupFavoritesCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        favoritesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        favoritesCollectionView?.register(FavoritesCell.self, forCellWithReuseIdentifier: FavoritesCell.identifier)
        favoritesCollectionView?.frame = view.bounds
        favoritesCollectionView?.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        favoritesCollectionView?.contentInsetAdjustmentBehavior = .automatic
        favoritesCollectionView?.allowsMultipleSelection = true
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        favoritesCollectionView?.delegate = self
        favoritesCollectionView?.dataSource = self
        
        view.addSubview(favoritesCollectionView ?? UICollectionView())
    }
}





//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension Favorites: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoritesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoritesCell.identifier, for: indexPath) as! FavoritesCell
        
        let unsplashPhoto = favoritesImages[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        

        
        return cell
        }


    }

//MARK: - UICollectionViewDelegateFlowLayout

extension Favorites: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        return CGSize(width: width/3 - 1, height: width/3 - 1)
    }
}
