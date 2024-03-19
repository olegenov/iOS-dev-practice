//
//  Picture.swift
//  GalleryApp
//
//  Created by Никита Китаев on 19.03.2024.
//

import UIKit

class Picture {
    let image: UIImage
    
    init(stringUrl: String) {
        guard let url = URL(string: stringUrl) else {
            image = UIImage()
            return
        }
        
        guard let imageData = try? Data(contentsOf: url) else {
            image = UIImage()
            return
        }
        
        guard let downloadedImage = UIImage(data: imageData) else {
            image = UIImage()
            return
        }
        
        print("")
        self.image = downloadedImage
    }
}
