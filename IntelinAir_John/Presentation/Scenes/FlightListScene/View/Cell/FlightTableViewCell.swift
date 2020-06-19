//
//  FlightTableViewCell.swift
//  IntelinAir_John
//
//  Created by John Harutyunyan on 6/12/20.
//  Copyright © 2020 John Harutyunyan. All rights reserved.
//

import UIKit
import Kingfisher

class FlightTableViewCell: BaseTableViewCell {
    
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var flightImageView: UIImageView!
    
    
    // MARK: - Life Cycles
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK: - Internal functions
    internal func fill(with viewModel: FlightRowViewModel) {
        nameLabel.text = viewModel.name
        
        if let imagePath = viewModel.imagePath,
            let downloadUrl = URL(string: imagePath) {
            
            let resourse = ImageResource(downloadURL: downloadUrl)
            flightImageView.kf.setImage(with: resourse,
                                       options: [.transition(.fade(1))])
        }
    }
}
