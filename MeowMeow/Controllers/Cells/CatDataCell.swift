//
//  CatDataCell.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 16/03/22.
//

import UIKit

class CatDataCell: UITableViewCell {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var interactedDateLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var reactionImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(isFavorite: Bool, catData: BreedsModel, interactedDate: Date) {
        self.descriptionLabel.text = catData.name
        if let urlString = catData.image?.url,
            let url = URL(string: urlString) {
            self.catImage.download(from: url)
        }
        
        let likeImage = #imageLiteral(resourceName: "like").withRenderingMode(.alwaysTemplate)
        let dislikeImage = #imageLiteral(resourceName: "dislike").withRenderingMode(.alwaysTemplate)
        let green = UIColor(named: "Green")
        self.reactionImage.image = isFavorite ? likeImage : dislikeImage
        self.reactionImage.tintColor = isFavorite ? green : .red
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/YYYY"
        let dateString = dateFormatter.string(from: interactedDate)
        interactedDateLabel.text = "Date interaction: \(dateString)"
    }
}
