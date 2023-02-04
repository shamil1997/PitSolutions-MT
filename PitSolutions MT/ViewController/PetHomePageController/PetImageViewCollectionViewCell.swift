//
//  PetImageViewCollectionViewCell.swift
//  PitSolutions MT
//
//  Created by Iris Medical Solutions on 02/02/23.
//

import UIKit
import SDWebImage

class PetImageViewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var showPetImage: UIImageView!
    @IBOutlet weak var showPetNameLbl: UILabel!
    
    
    
    func setupCollectionViewWth(_ cellData : PetsDetails) {
        showPetImage.contentMode = .scaleToFill
        showPetImage.layer.cornerRadius = 10
        showPetImage.clipsToBounds = true
        showPetImage.translatesAutoresizingMaskIntoConstraints = true
        showPetImage.sd_setImage(with: URL(string: cellData.image_url))
        showPetNameLbl.text = cellData.title
    }
    
}
