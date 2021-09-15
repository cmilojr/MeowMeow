//
//  Prueba.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import UIKit
import NotificationBannerSwift

class GenerationsVC: UIViewController {
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var emptyState: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var blockBackground: UIView!
    @IBOutlet weak var favoritePokemons: UIButton!
    
    fileprivate var generationsViewModel = GenerationsVM()
    fileprivate var generations = [Description]()
    fileprivate var pokemonsInGeneration: [Description]?
    fileprivate var goToFav = false
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: Constants.CellIdentifier.categoryCell, bundle: nil)
        categoriesCollectionView.register(nib, forCellWithReuseIdentifier: Constants.CellIdentifier.categoryCell)
        categoriesCollectionView.dataSource = self
        categoriesCollectionView.delegate = self
        categoriesCollectionView.backgroundColor = .none
        categoriesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
        
    fileprivate func loading(show: Bool) {
        self.loadingSpinner.isHidden = !show
        self.view.isUserInteractionEnabled = !show
        self.blockBackground.isHidden = !show
        if show {
            self.loadingSpinner.startAnimating()
        } else {
            self.loadingSpinner.stopAnimating()
        }
    }
    
    @IBAction func favoritePokemonAction(_ sender: Any) {
        do {
            self.pokemonsInGeneration = try generationsViewModel.getListOfFavoritePokemons()
            self.goToFav = true
            self.performSegue(withIdentifier: "goToSearch", sender: nil)
        } catch {
            let banner = NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
            DispatchQueue.main.async {
                banner.show()
            }
        }
    }
    
    fileprivate func getCategories() {
        generationsViewModel.getGenerations { generationsRes, error in
            if let e = error {
                let banner = NotificationBanner(title: "Error", subtitle: e.localizedDescription, style: .danger)
                DispatchQueue.main.async {
                    banner.show()
                }
            } else if let generations = generationsRes {
                self.generations = generations.results
                DispatchQueue.main.async {
                    self.categoriesCollectionView.reloadData()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        getCategories()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? SearchVC {
            vc.pokemonList = pokemonsInGeneration
            vc.goToFav = self.goToFav
        }
    }
}

extension GenerationsVC: UICollectionViewDataSource {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if generations.count == 0 {
            emptyState.isHidden = false
            categoriesCollectionView.isHidden = true
        } else {
            emptyState.isHidden = true
            categoriesCollectionView.isHidden = false
        }
        return generations.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.categoryCell, for: indexPath) as! CategoryCell
        cell.setup(titleCategory: generations[indexPath.row].name)
        return cell
    }
}

extension GenerationsVC: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 2) // 15 because of paddings
        let height = ((collectionView.frame.width - 15) / 4)

        return CGSize(width: width, height: height)
   }
}

extension GenerationsVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.loading(show: true)
        generationsViewModel.getPokemonAvailableInGeneration(generationUrl: generations[indexPath.item].url) { itemsRes, error in
            if let e = error {
                let banner = NotificationBanner(title: "Error", subtitle: e.localizedDescription, style: .danger)
                DispatchQueue.main.async {
                    banner.show()
                }
            } else if let items = itemsRes {
                self.pokemonsInGeneration = items.pokemon_species
            }
            DispatchQueue.main.async {
                self.loading(show: false)
                self.categoriesCollectionView.deselectItem(at: indexPath, animated: false)
                self.performSegue(withIdentifier: "goToSearch", sender: nil)
                self.goToFav = false
            }
        }
    }
}
