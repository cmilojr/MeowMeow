//
//  PostDataCell.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 16/03/22.
//

import UIKit

class PostDataCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dotImage: UIImageView!
    @IBOutlet weak var starImaage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(isFavorite: Bool,isReaded: Bool, description: String) {
        self.descriptionLabel.text = description
        if !isReaded {
            dotImage.isHidden = false
            starImaage.isHidden = true
        } else {
            if isFavorite {
                starImaage.isHidden = false
            } else {
                dotImage.isHidden = true
            }
        }
    }
}
