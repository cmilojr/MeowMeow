//
//  HomeVC.swift
//  MeowMeow
//
//  Created by Camilo Jiménez on 19/03/22.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    var totalCats = [BreedsModel]()
    var viewModel = HomeVM()
    var currentCat = 0
    
    func getNextCat() {
        let cat = totalCats[currentCat]
        if let urlString = cat.image?.url,
            let url = URL(string: urlString) {
            catImage.download(from: url)
        }
        if currentCat != totalCats.count {
            currentCat += 1
        } else {
            currentCat = 0
        }
    }
    
    @IBAction func LikeAction(_ sender: Any) {
        do {
            try viewModel.storeCat(cat: totalCats[currentCat], status: true)
            print(try viewModel.storage?.getCats())
        } catch {
            print(error)
        }
        getNextCat()
    }

    @IBAction func DislikeAction(_ sender: Any) {
        do {
            try viewModel.storeCat(cat: totalCats[currentCat], status: false)
        } catch {
            print(error)
        }
        getNextCat()
    }
    
    fileprivate func setupReactionButton() {
        likeButton.layer.borderWidth = 10
        likeButton.layer.cornerRadius = 50
        likeButton.layer.borderColor = UIColor.green.cgColor
        likeButton.setTitle("", for: .normal)
        
        dislikeButton.layer.borderWidth = 10
        dislikeButton.layer.cornerRadius = 50
        dislikeButton.layer.borderColor = UIColor.red.cgColor
        dislikeButton.setTitle("", for: .normal)
    }
    
    fileprivate func getDataFromServer() {
        viewModel.getAllPosts { cats, error in
            if let error = error {
                print(error)
            } else if let cats = cats {
                self.totalCats = cats
                DispatchQueue.main.async {
                    self.getNextCat()
                }
            }
        }
    }
    
    fileprivate func setupVM() {
        let remoteConnection = RemoteConnection(networkManager: NativeNetworkManager())
        viewModel.remoteData = remoteConnection
        viewModel.storage = SQLiteLocalStorage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupReactionButton()
        setupVM()
        getDataFromServer()
    }
}
