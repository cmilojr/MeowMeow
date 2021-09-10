//
//  CellController.swift
//  iBuy
//
//  Created by Camilo Jimenez on 5/08/21.
//

import UIKit

class CountryCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var checkmarkImageView: UIImageView?
    @IBOutlet weak var countryFlag: UIImageView?
    @IBOutlet weak var container: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(countryTitle: String, flagImage: UIImage) {
        self.titleLabel?.text = countryTitle
        self.countryFlag?.image = flagImage
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            container?.backgroundColor = Constants.CustomColors.mintGreen
            checkmarkImageView?.isHidden = false
        } else {
            container?.backgroundColor = UIColor.white
            checkmarkImageView?.isHidden = true
        }
    }
}

