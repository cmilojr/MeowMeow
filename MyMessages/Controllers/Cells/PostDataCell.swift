//
//  PostDataCell.swift
//  MyMessages
//
//  Created by Camilo Jiménez on 16/03/22.
//

import UIKit

class PostDataCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(isFavorite: Bool, description: String) {
        self.descriptionLabel.text = description
    }
}
