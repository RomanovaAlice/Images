//
//  ImagesCell.swift
//  Images
//
//  Created by Alice Romanova on 06.06.2022.
//

import UIKit
import SDWebImage

final class ImagesCell: UICollectionViewCell {
    
    //MARK: - Properties
    static let identifier = "ImagesCell"
    
    
    //MARK: - Computed Properties
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .gray
       imageView.contentMode = .scaleAspectFill
        
       return imageView
   }()
    
    private lazy var checkmarkView: UIImageView = {
        let checkmark = UIImage(named: "checkmark")
        let checkmarkView = UIImageView(image: checkmark)
        checkmarkView.alpha = 0
        
        return checkmarkView
    }()
    
    var unsplashPhoto: PictureParametets! {
        didSet {
            let imageURL = unsplashPhoto.urls["regular"]
            guard let imageUrl = imageURL, let URL = URL(string: imageUrl) else { return }
            imageView.sd_setImage(with: URL, completed: nil)
        }
    }
     
    //MARK: - Override properties
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    //MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraintsForImageView()
        setupConstraintsForCheckmarkView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    private func updateSelectedState() {
        imageView.alpha = isSelected ? 0.7 : 1
        checkmarkView.alpha = isSelected ? 1 : 0
    }
    
    //MARK: - Override methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraintsForImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    private func setupConstraintsForCheckmarkView() {
        checkmarkView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(checkmarkView)
        
        checkmarkView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8).isActive = true
        checkmarkView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -8).isActive = true
    }
}
