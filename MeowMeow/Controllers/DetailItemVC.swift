//
//  DetailItemVC.swift
//  iBuy
//
//  Created by Camilo Jimenez on 10/08/21.
//

import UIKit
import NotificationBannerSwift

class DetailItemVC: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var temperamentLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var catImage: UIImageView!
    
    var selectedPost: DataModel? {
        didSet {
            self.catInfo = selectedPost?.catInfo
        }
    }

    var catInfo: BreedsModel? {
        didSet {
            updateUserInfoInUI()
        }
    }
    
    fileprivate func updateUserInfoInUI() {
        DispatchQueue.main.async {
            self.nameLabel.text = self.catInfo?.name
            self.weightLabel.text = "Weight: \(self.catInfo?.weight.metric ?? "0") kg"
            self.temperamentLabel.text = "Temperament: \(self.catInfo?.temperament ?? "")"
            self.originLabel.text = "Origin: \(self.catInfo?.origin ?? "")"
            self.descriptionLabel.text = self.catInfo?.description
            self.lifeSpanLabel.text = "Life span: \(self.catInfo?.life_span ?? "") years"
            if let urlString = self.catInfo?.image?.url,
               let url = URL(string: urlString) {
                self.catImage.download(from: url)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
