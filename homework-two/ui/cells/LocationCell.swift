//
//  LocationCell.swift
//  homework-two
//
//  Created by Emre Muhammet Engin on 30.12.2022.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var locationType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
