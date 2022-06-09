//
//  Images.swift
//  Images
//
//  Created by Alice Romanova on 06.06.2022.
//

import UIKit

final class Images: UIViewController {
    
    //MARK: Variable
    
    private let networkDataFetcher = NetworkDataFetcher()
    private let itemsPerRow: CGFloat = 2
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    private var collectionView: UICollectionView?
    private var images = [PictureParametets]()

    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        tabBarItem.image = .add
        
        setupCollectionView()
        setupConstraintsForCollectionView()
        
        setupSearchBar()
    }
    
    
     //MARK: setupCollectoinView
    
    private func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView?.register(ImagesCell.self, forCellWithReuseIdentifier: ImagesCell.identifier)
        collectionView?.frame = view.bounds
        collectionView?.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        collectionView?.contentInsetAdjustmentBehavior = .automatic
        collectionView?.allowsMultipleSelection = true
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        view.addSubview(collectionView ?? UICollectionView())
    }
    
    private func setupConstraintsForCollectionView() {
        collectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
    }
 
    
    //MARK: setupSearchBar
    
    private func setupSearchBar() {
        let seacrhController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = seacrhController
        
        seacrhController.hidesNavigationBarDuringPresentation = false
        seacrhController.obscuresBackgroundDuringPresentation = false
        
        seacrhController.searchBar.delegate = self
    }
}





// MARK: UISearchBarDelegate

extension Images: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        self.networkDataFetcher.fetchImages(request: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.images = fetchedPhotos.results
                self?.collectionView?.reloadData()
            }
    }
}


//MARK: UICollectionViewDataSource, UICollectionViewDelegate

extension Images: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImagesCell.identifier, for: indexPath) as! ImagesCell
        
        let unsplashPhoto = images[indexPath.item]
        cell.unsplashPhoto = unsplashPhoto
        
        return cell
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension Images: UICollectionViewDelegateFlowLayout { // Делаем так чтобы яйчейки принимали размер приходящих фото
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let image = images[indexPath.item]
        
        let paddingSpace = sectionInserts.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        
        let widthPerItem = availableWidth / itemsPerRow
        let height = CGFloat(image.height) * widthPerItem / CGFloat(image.width)
        
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInserts.left
    }
}
