//
//  PostDataCell.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 16/03/22.
//

import UIKit

class CatDataCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var catImaage: UIImageView!
    @IBOutlet weak var reactionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(isFavorite: Bool, catData: BreedsModel) {
        self.descriptionLabel.text = catData.name
        if let urlString = catData.image?.url,
            let url = URL(string: urlString) {
            self.catImaage.download(from: url)
        }
        
        let likeImage = #imageLiteral(resourceName: "like").withTintColor(.green)
        let dislikeImage = #imageLiteral(resourceName: "like").withTintColor(.red)
        
        self.reactionImage.image = isFavorite ? likeImage : dislikeImage
    }
}
