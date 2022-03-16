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
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    private let detailItemVM = DetailItemVM()
    var selectedMessage: PostModel?
    
    private var isFavorite: Bool! {
        didSet {
            if let fav = isFavorite {
                if fav {
                    self.favoriteButton.setImage(UIImage(named: "HeartFill"), for: .normal)
                } else {
                    self.favoriteButton.setImage(UIImage(named: "HeartNotFill"), for: .normal)
                }
            }
        }
    }
    
    fileprivate func setupDetail(_ post: PostModel) {
//        var moves = ""
//        self.pokemonNameLabel.text = pokemon.name.capitalizingFirstLetter()
//        self.productImage.download(from: (pokemon.sprites.front_default))
//        self.pokemonIdLabel.text = "# \(pokemon.id)"
//        self.weightLabel.text = "\(pokemon.weight) Lbs"
//        self.heightLabel.text =
//            "\(pokemon.height) Feet"
//        let first = pokemon.moves.count - 5
//        let total = first > 0 ? 5 : first != -5 ? first * -1 : 0
//        for i in 0..<total {
//            let move = pokemon
//                .moves[i]
//                .move
//                .name
//                .capitalizingFirstLetter()
//                .replacingOccurrences(of: "-", with: " ")
//            if i == 0 {
//                moves += move
//            } else {
//                moves += ", \(move)"
//            }
//        }
//        self.movesLabel.text = moves
    }
    
    private func setupPokemonDetail(name: String) {
//        detailItemVM.getPokemonDetail(name: name) { pokemonRes, error in
//            if let e = error {
//                let banner = NotificationBanner(title: "Error", subtitle: e.localizedDescription, style: .danger)
//                DispatchQueue.main.async {
//                    banner.show()
//                }
//            } else if let pokemonInfo = pokemonRes {
//                DispatchQueue.main.async {
//                    self.setupDetail(pokemonInfo)
//                }
//            }
//        }
    }
    
    @IBAction func savePokemon(_ sender: Any) {
//        if !isFavorite {
//            do {
//                try detailItemVM.savePokemonDetail(self.pokemonName!)
//                self.isFavorite = !self.isFavorite
//            } catch {
//                print(error)
//                let banner = NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
//                DispatchQueue.main.async {
//                    banner.show()
//                }
//            }
//        } else {
//            do {
//                try detailItemVM.deletePokemon(self.pokemonName!)
//                self.isFavorite = !self.isFavorite
//                if goToFav {
//                    self.navigationController?.popToRootViewController(animated: true)
//                }
//            } catch {
//                let banner = NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
//                DispatchQueue.main.async {
//                    banner.show()
//                }
//            }
//        }
    }
//    fileprivate func checkIsFavorite(_ pn: Description) {
//        do {
//            self.isFavorite = try self.detailItemVM.checkPokemon(pn)
//        } catch {
//            let banner = NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
//            DispatchQueue.main.async {
//                banner.show()
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.title = "Pokemon information"
//        if let pn = pokemonName {
//            self.setupPokemonDetail(name: pn.name)
//            self.checkIsFavorite(pn)
//        } else {
//            let banner = NotificationBanner(title: "Error", subtitle: "No pokemon selected", style: .danger)
//            DispatchQueue.main.async {
//                banner.show()
//            }
//        }
    }
}
