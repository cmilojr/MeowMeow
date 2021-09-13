//
//  DetailItemVC.swift
//  iBuy
//
//  Created by Camilo Jimenez on 10/08/21.
//

import UIKit
import NotificationBannerSwift

class DetailItemVC: UIViewController {
    @IBOutlet weak var titleOfProduct: UILabel!
    @IBOutlet weak var oldPriceProduct: UILabel!
    @IBOutlet weak var newPriceProduct: UILabel!
    @IBOutlet weak var discountProduct: UILabel!
    @IBOutlet weak var feeProduct: UILabel!
    @IBOutlet weak var productCondition: UILabel!
    @IBOutlet weak var shipping: UILabel!
    @IBOutlet weak var mercadoPagoAccepted: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var discountStack: UIStackView!
    private let detailItemVM = DetailItemVM()
    private var pokemonInfo: PokemonDetailModel?
    var pokemonName: String?
    
    fileprivate func strikethroughLabel(oldPrice: String) -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: oldPrice)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    fileprivate func setupDetail(_ pokemon: PokemonDetailModel) {
        self.titleOfProduct.text = pokemon.name
        self.productImage.download(from: (pokemon.sprites.front_default))
        // TODO - Que hacer si no llega imagen

        //self.mercadoPagoAccepted.text = product.accepts_mercadopago! ? "Este producto acepta mercado pago!." : "Este producto no acepta mercado pago."
        //self.shipping.text = product.shipping.free_shipping! ? "Envio gratuito!." : "Envio por calcular."
        //self.productCondition.text = product.condition! == "new" ? "Nuevo." : "Usado."
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Detalle del producto"
        if let pn = pokemonName {
            self.setupPokemonDetail(name: pn)
        } else {
            let banner = NotificationBanner(title: "Error", subtitle: "No pokemon selected", style: .danger)
            DispatchQueue.main.async {
                banner.show()
            }
        }
    }
}
