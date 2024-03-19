//
//  Gallery.swift
//  GalleryApp
//
//  Created by Никита Китаев on 19.03.2024.
//

import UIKit

class Gallery: UICollectionView {
    enum Constants {
        static let horizontalGap: CGFloat = 9
    }
    
    var data: [Picture] = []
    var cardSize: CGFloat = 256
    
    init() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
    
        super.init(frame: .zero, collectionViewLayout: layout)
        
        showsVerticalScrollIndicator = false
        
        register(PictureView.self, forCellWithReuseIdentifier: "PictureCell")
        
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(_ data: [Picture]) {
        self.data = data
        reloadData()
    }
    
    func updateCardSize(_ size: CGFloat) {
        self.cardSize = size
        reloadData()
    }
}

extension Gallery: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as! PictureView
        let picture = data[indexPath.item]
        
        cell.configure(with: picture)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cardSize, height: cardSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.horizontalGap
    }
}
