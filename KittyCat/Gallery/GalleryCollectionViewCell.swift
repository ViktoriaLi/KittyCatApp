//
//  GalleryCollectionViewCell.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var catImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        catImageView.image = nil
    }
    
    func configure(cat: ShortImageModel) {
        self.catImageView.clipsToBounds = true
        self.catImageView.layer.cornerRadius = 8
        catImageView.loadImage(from: cat.url)
    }

}
