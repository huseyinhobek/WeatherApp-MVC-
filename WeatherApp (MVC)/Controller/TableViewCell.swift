//
//  TableViewCell.swift
//  WeatherApp (MVC)
//
//  Created by Hüseyin HÖBEK on 24.11.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    static let identifier = "TableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(with model: WeatherModelDaily) {
        dayLabel.text = model.time
        iconImage.image = UIImage(systemName: model.conditionName)
        minTempLabel.text = model.minTemperatureString
        maxTempLabel.text = model.maxTemperatureString
    }
 
    
}
