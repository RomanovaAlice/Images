//
//  FavoritesCell.swift
//  Images
//
//  Created by Alice Romanova on 23.07.2022.
//

import UIKit
import SDWebImage

class FavoritesCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "FavoritesCell"
    
    //MARK: - Computed Properties
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .green
        
       return imageView
   }()
    
    var unsplashPhoto: PictureParametets! {
        didSet {
            let imageURL = unsplashPhoto.urls["regular"]
            guard let imageUrl = imageURL, let URL = URL(string: imageUrl) else { return }
            imageView.sd_setImage(with: URL, completed: nil)
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        backgroundColor = .green
        
        setupImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    
}
