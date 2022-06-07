//
//  ImagesCell.swift
//  Images
//
//  Created by Alice Romanova on 06.06.2022.
//

import UIKit
import SDWebImage

class ImagesCell: UICollectionViewCell {
    
    //MARK: Variables
    static let identifier = "Cell"
    
    
    //MARK: Computed Properties
    
    let imageView: UIImageView = {
        
       let imageView = UIImageView()
        imageView.backgroundColor = .gray
       imageView.contentMode = .scaleAspectFill
        
       return imageView
   }()
    
    var unsplashPhoto: PictureParametets! {
        didSet {
            let imageURL = unsplashPhoto.urls["regular"]
            guard let imageUrl = imageURL, let URL = URL(string: imageUrl) else { return }
            imageView.sd_setImage(with: URL, completed: nil)
        }
    }
    
    
    //MARK: Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Methods
    
    private func setupConstraintsForImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
}
