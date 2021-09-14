//
//  DetailItemVC.swift
//  iBuy
//
//  Created by Camilo Jimenez on 10/08/21.
//

import UIKit
import NotificationBannerSwift

class DetailItemVC: UIViewController {
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIdLabel: UILabel!
    @IBOutlet weak var movesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    private let detailItemVM = DetailItemVM()
    private var pokemonInfo: PokemonDetailModel?
    var pokemonName: Description?
    
    fileprivate func strikethroughLabel(oldPrice: String) -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: oldPrice)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    fileprivate func setupDetail(_ pokemon: PokemonDetailModel) {
        var moves = ""
        self.pokemonNameLabel.text = pokemon.name.capitalizingFirstLetter()
        self.productImage.download(from: (pokemon.sprites.front_default))
        self.pokemonIdLabel.text = "# \(pokemon.id)"
        self.weightLabel.text = "\(pokemon.weight) Lbs"
        self.heightLabel.text =
        "\(pokemon.height) Feet"
        let first = pokemon.moves.count - 5
        let total = first > 0 ? 5 : first != -5 ? first * -1 : 0
        for i in 0..<total {
            let move = pokemon
                .moves[i]
                .move
                .name
                .capitalizingFirstLetter()
                .replacingOccurrences(of: "-", with: " ")
            if i == 0 {
                moves += move
            } else {
                moves += ", \(move)"
            }
        }
        self.movesLabel.text = moves
    }
    
    private func setupPokemonDetail(name: String) {
        detailItemVM.getPokemonDetail(name: name) { pokemonRes, error in
            if let e = error {
                let banner = NotificationBanner(title: "Error", subtitle: e.localizedDescription, style: .danger)
                DispatchQueue.main.async {
                    banner.show()
                }
            } else if let pokemonInfo = pokemonRes {
                DispatchQueue.main.async {
                    self.setupDetail(pokemonInfo)
                }
            }
        }
    }
    
    @IBAction func savePokemon(_ sender: Any) {
        do {
            try detailItemVM.savePokemonDetail(self.pokemonName!)
            //let res = try detailItemVM.getListOfFavoritePokemons()
            //print(res)
        } catch {
            print(error)
            let banner = NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
            DispatchQueue.main.async {
                banner.show()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pokemon information"
        if let pn = pokemonName {
            self.setupPokemonDetail(name: pn.name)
            self.detailItemVM.checkPokemon(pn)
        } else {
            let banner = NotificationBanner(title: "Error", subtitle: "No pokemon selected", style: .danger)
            DispatchQueue.main.async {
                banner.show()
            }
        }
        
        
    }
}
