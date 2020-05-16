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
    
    func configure(cat: ShortImageModel) {
        //self.contentView.cornerRadius = 8
        self.catImageView.clipsToBounds = true
        self.catImageView.layer.cornerRadius = 8
        catImageView.loadImage(from: cat.url)
    }

}
