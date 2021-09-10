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
    var itemsList: ProductsResponse?
    fileprivate var selectedProduct: ProductResponse? = nil
    let searchController = UISearchController(searchResultsController: nil)

    private let searchVM = SearchVM()
    private var searchText: String? {
        didSet {
            if let text = searchText {
                searchInApi(text)
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
    
    fileprivate func searchInApi(_ text: String) {
        self.loading(show: true)
        searchVM.getRelatedItems(itemName: text) { itemRes, error in
            if let e = error {
                let banner = NotificationBanner(title: "Error", subtitle: e.localizedDescription, style: .danger)
                DispatchQueue.main.async {
                    banner.show()
                }

            } else if let items = itemRes {
                self.itemsList = items
                self.itemsContainerView.reloadData()
            }
            self.loading(show: false)
        }
    }
    
    fileprivate func setupCollectionView() {
        let nib = UINib(nibName: Constants.CellIdentifier.productCell, bundle: nil)
        itemsContainerView.register(nib, forCellWithReuseIdentifier: Constants.CellIdentifier.productCell)
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
        setupNavigationBar()
        setupCollectionView()
        setupSearchController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DetailItemVC {
            vc.product = selectedProduct
        }
    }
}

extension SearchVC: UICollectionViewDataSource {
    internal func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if itemsList?.results.count == nil || itemsList?.results.count == 0 {
            self.itemsContainerView.isHidden = true
            self.emptyState.isHidden = false
        } else {
            self.itemsContainerView.isHidden = false
            self.emptyState.isHidden = true
        }
        return itemsList?.results.count ?? 0
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifier.productCell, for: indexPath) as! ProductCell
        cell.setup(productTitle: itemsList?.results[indexPath.row].title ?? "", productPrice: itemsList?.results[indexPath.row].price ?? 0, productImageUrl: itemsList?.results[indexPath.row].thumbnail ?? "", oldPrice: itemsList?.results[indexPath.row].original_price ?? 0)
        return cell
    }
}

extension SearchVC: UICollectionViewDelegateFlowLayout {
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 15) / 2) // 15 because of paddings
        let height = ((collectionView.frame.width - 15) / 1)

        return CGSize(width: width, height: height)
   }
}

extension SearchVC: UISearchControllerDelegate, UISearchBarDelegate {
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let itemName = searchBar.text else {return}
        self.searchText = itemName
        self.searchController.dismiss(animated: true, completion: nil)
    }
}

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedProduct = itemsList?.results[indexPath.item]
        self.itemsContainerView.deselectItem(at: indexPath, animated: false)
        self.performSegue(withIdentifier: "goToDetail", sender: nil)
    }
}
