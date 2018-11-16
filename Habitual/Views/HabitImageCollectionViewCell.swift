//
//  HabitImageCollectionViewCell.swift
//  Habitual
//
//  Created by Sarin Swift on 11/15/18.
//  Copyright © 2018 sarinswift. All rights reserved.
//

import UIKit

class HabitImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "habit image cell"

    @IBOutlet weak var habitImage: UIImageView!
    
    // this static var allows to access this variable in AddHabitViewController
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func setImage(image: UIImage) {
        self.habitImage.image = image
    }

}
