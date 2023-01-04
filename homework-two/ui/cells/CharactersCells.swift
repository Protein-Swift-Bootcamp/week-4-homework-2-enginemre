//
//  CharactersCells.swift
//  homework-two
//
//  Created by Emre Muhammet Engin on 30.12.2022.
//

import UIKit
class CharactersCells: UITableViewCell {

    @IBOutlet weak var infoButton: UIImageView!
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
