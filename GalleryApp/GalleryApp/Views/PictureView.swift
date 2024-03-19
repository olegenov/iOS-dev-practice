//
//  Pricture.swift
//  GalleryApp
//
//  Created by Никита Китаев on 19.03.2024.
//

import UIKit

class PictureView: UICollectionViewCell {
    enum Constants {
        static let borderRadius: CGFloat = 16
    }
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        configurePicture()
        configureBorders()
    }
    
    private func configureBorders() {
        layer.cornerRadius = Constants.borderRadius
        layer.masksToBounds = true
    }
    
    private func configurePicture() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with picture: Picture) {
        imageView.image = picture.image
    }
}

