//
//  SearchVC.swift
//  iBuy
//
//  Created by Camilo Jimenez on 9/08/21.
//

import UIKit
import NotificationBannerSwift

class SearchVC: UIViewController {
    @IBOutlet weak var itemsContainerView: UICollectionView!
    @IBOutlet weak var emptyState: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var blockBackground: UIView!
    let searchMV = SearchVM()
    var pokemonList: [Description]?
    var filteredPokemonList: [Description]?
    fileprivate var selectedPokemon: String? = nil
    let searchController = UISearchController(searchResultsController: nil)
    
    private func reloadData() {
        self.filteredPokemonList = self.pokemonList
        self.itemsContainerView.reloadData()
    }
    
    private var searchText: String? {
        didSet {
            if let text = searchText {
                if text != "" {
                    self.filterData(searchText: text)
                }
            }
        }
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
    
    fileprivate func filterData(searchText: String) {
        self.filteredPokemonList = []
        self.loading(show: true)
        if let pl = pokemonList {
            for pokeList in pl {
                if pokeList.name.lowercased().contains(searchText.lowercased()) {
                    self.filteredPokemonList?.append(pokeList)
                }
            }
            self.itemsContainerView.reloadData()
            self.loading(show: false)
        } else {
            let banner = NotificationBanner(title: "Error", subtitle: "The server has problems", style: .danger)
            DispatchQueue.main.async {
                banner.show()
            }
        }
    }

    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: Constants.CellIdentifier.categoryCell, bundle: nil)
        itemsContainerView.register(nib, forCellWithReuseIdentifier: Constants.CellIdentifier.categoryCell)
        itemsContainerView.dataSource = self
        itemsContainerView.delegate = self
        itemsContainerView.backgroundColor = .none
        itemsContainerView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    fileprivate func setupNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = Constants.CustomColors.green
        appearance.titleTextAttributes = [.foregroundColor: Constants.CustomColors.mintGreen!]
        appearance.largeTitleTextAttributes = [.foregroundColor: Constants.CustomColors.mintGreen!]
        self.navigationController?.navigationBar.tintColor = Constants.CustomColors.mintGreen
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.backItem?.title = ""
    }
    
    fileprivate func setupSearchController() {
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.inputView?.backgroundColor = .white
        searchController.searchBar.placeholder = "Ej: Bolso, Zapatos"
        searchController.searchBar.tintColor = .white
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filteredPokemonList = self.pokemonList
        setupNavigationBar()
        setupCollectionView()
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailItemVC {
            vc.pokemonName = self.selectedPokemon
        }
    }
}

extension SearchVC: UICollectionViewDataSource {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.filteredPokemonList?.count == nil || self.filteredPokemonList?.count == 0 {
            self.itemsContainerView.isHidden = true
            self.emptyState.isHidden = false
        } else {
            self.itemsContainerView.isHidden = false
            self.emptyState.isHidden = true
        }
        return self.filteredPokemonList?.count ?? 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.categoryCell, for: indexPath) as! CategoryCell
        //cell.setup(productTitle: pokemonList?[indexPath.row].name ?? "", productPrice: 0, productImageUrl: "", oldPrice: 0)
        cell.setup(titleCategory: self.filteredPokemonList?[indexPath.row].name ?? "")
        return cell
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 2) // 15 because of paddings
        let height = ((collectionView.frame.width - 15) / 4)
        
        return CGSize(width: width, height: height)
    }
}

extension SearchVC: UISearchControllerDelegate, UISearchBarDelegate {
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let itemName = searchBar.text else {return}
        self.searchText = itemName
        self.searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            self.searchText = searchText
        } else {
            self.filteredPokemonList = self.pokemonList
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.reloadData()
    }
}

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedPokemon = self.filteredPokemonList![indexPath.row].name
        self.itemsContainerView.deselectItem(at: indexPath, animated: false)
        self.performSegue(withIdentifier: "goToDetail", sender: nil)
    }
}
