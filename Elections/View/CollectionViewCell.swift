//
//  CollectionViewCell.swift
//  Elections
//
//  Created by Vladimir Bulakhov on 30/04/2020.
//  Copyright © 2020 Vladimir Bulakhov. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shortName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var indexpath: IndexPath?
    
}
