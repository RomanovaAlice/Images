//
//  Images.swift
//  Images
//
//  Created by Alice Romanova on 06.06.2022.
//

import UIKit

final class Images: UIViewController {
    
    //MARK: - Arrays
    private var selectedImages = [UIImage]()
    private var images = [PictureParametets]()
    
    //MARK: - Private properties
    private let networkDataFetcher = NetworkDataFetcher()
    private var imagesCollectionView: UICollectionView?
    private let sectionInserts = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    private let itemsPerRow: CGFloat = 2
    
    //MARK: - Computed properties
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
    }()
    
    private lazy var numberOfSelectedPhotos: Int = {
        return imagesCollectionView?.indexPathsForSelectedItems?.count ?? 0
    }()

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupCollectionView()
        setupConstraintsForCollectionView()
        setupSearchBar()
        setupNavigationBar()
    }
    
     //MARK: - setupCollectoinView
    
    private func setupCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        imagesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        imagesCollectionView?.register(ImagesCell.self, forCellWithReuseIdentifier: ImagesCell.identifier)
        imagesCollectionView?.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        imagesCollectionView?.contentInsetAdjustmentBehavior = .automatic
        imagesCollectionView?.allowsMultipleSelection = true
        
        imagesCollectionView?.delegate = self
        imagesCollectionView?.dataSource = self
    }
    
    private func setupConstraintsForCollectionView() {
        imagesCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imagesCollectionView ?? UICollectionView())
        
        imagesCollectionView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imagesCollectionView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imagesCollectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imagesCollectionView?.topAnchor.constraint(equalTo: view.topAnchor, constant: 130).isActive = true
    }
 
    //MARK: - setupSearchBar
    
    private func setupSearchBar() {
        let seacrhController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = seacrhController
        
        seacrhController.hidesNavigationBarDuringPresentation = false
        seacrhController.obscuresBackgroundDuringPresentation = false
        
        seacrhController.searchBar.delegate = self
    }
    
    //MARK: - setupNavigationBar
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = addBarButtonItem
        addBarButtonItem.isEnabled = false
    }
    
    private func refresh() {
        selectedImages.removeAll()
        addBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
    }

    //MARK: - @objc method "add"
    
    @objc private func add() {
        
        let selectedPictures = imagesCollectionView?.indexPathsForSelectedItems?.reduce([], { (photos, indexPath) -> [PictureParametets] in
            var pictures = photos
            let image = self.images[indexPath.item]
            pictures.append(image)
            return pictures
        })
        let alert = UIAlertController(title: "Внимание!",
                                      message: "\(selectedPictures!.count) изображнеия будут добавлены в раздел понравившиеся",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [weak self] _ in
            
            let tabBar = self?.tabBarController as! TabBarController
            let navigationViewController = tabBar.viewControllers?[1] as! UINavigationController
            let favoritesViewController = navigationViewController.topViewController as! Favorites
            
            favoritesViewController.favoritesImages.append(contentsOf: selectedPictures ?? [])
            favoritesViewController.favoritesCollectionView?.reloadData()
            
            self?.refresh()
        }))
        present(alert, animated: true)
    }
}





// MARK: - UISearchBarDelegate

extension Images: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.networkDataFetcher.fetchImages(request: searchText) { [weak self] (searchResults) in
                guard let fetchedPhotos = searchResults else { return }
                self?.images = fetchedPhotos.results
                self?.imagesCollectionView?.reloadData()
            }
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate

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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addBarButtonItem.isEnabled = numberOfSelectedPhotos > 0
        let cell = collectionView.cellForItem(at: indexPath) as! ImagesCell
        guard let image = cell.imageView.image else { return }
        selectedImages.append(image)
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
