//
//  CollectionViewCell.swift
//  WeatherApp (MVC)
//
//  Created by Hüseyin HÖBEK on 24.11.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: CollectionViewCell.self)
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var degreeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(with model: WeatherModelHourly) {
        timeLabel.text = model.time
        degreeLabel.text = model.temperatureString
        iconImage.image = UIImage(systemName: model.conditionName)
    }

}
