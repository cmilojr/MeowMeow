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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    private var viewModel = DetailItemVM()
    var selectedPost: BreedsModel?

    var userInfo: UserInformationModel? {
        didSet {
            updateUserInfoInUI()
        }
    }
    
    fileprivate func updateUserInfoInUI() {
        DispatchQueue.main.async {
            self.nameLabel.text = self.userInfo?.name
            self.emailLabel.text = self.userInfo?.email
            self.phoneLabel.text = self.userInfo?.phone
            self.websiteLabel.text = self.userInfo?.website
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.storage = SQLiteLocalStorage()
        self.descriptionLabel.text = selectedPost?.description
    }
}
