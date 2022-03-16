//
//  Prueba.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import UIKit
import NotificationBannerSwift

class MyMessagesVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyState: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var blockBackground: UIView!
    @IBOutlet weak var reloadData: UIBarButtonItem!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    fileprivate var viewModel = MyMessagesVM()
    fileprivate var favoritePosts: [PostModel]?
    fileprivate var allPosts: [PostModel]?
    fileprivate var goToFav = false
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: CellIdentifiers.postDataCell.resource, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CellIdentifiers.postDataCell.resource)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    fileprivate func setupNavigationControllerAppearance() {
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "Green")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    fileprivate func setupSegmentedControlAppearance() {
        let titleTextAttributesSelected = [NSAttributedString.Key.foregroundColor: UIColor(named: "Green")]
        let titleTextAttributesNormal = [NSAttributedString.Key.foregroundColor: UIColor.white]
        segmentedControl.setTitleTextAttributes(titleTextAttributesSelected, for: .selected)
        segmentedControl.setTitleTextAttributes(titleTextAttributesNormal, for: .normal)
    }
    
    fileprivate func loading(show: Bool) {
        DispatchQueue.main.async {
            self.loadingSpinner.isHidden = !show
            self.view.isUserInteractionEnabled = !show
            self.blockBackground.isHidden = !show
            if show {
                self.loadingSpinner.startAnimating()
            } else {
                self.loadingSpinner.stopAnimating()
            }
        }
    }
    
    fileprivate func getAllPosts() {
        self.loading(show: true)
        viewModel.getAllPosts { postsRes, error in
            if let e = error {
                let banner = NotificationBanner(title: "Error", subtitle: e.localizedDescription, style: .danger)
                self.loading(show: false)
                banner.show()
            } else if let posts = postsRes {
                self.allPosts = posts
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.loading(show: false)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        let networkManager = NativeNetworkManager()
        viewModel.remoteData =  RemoteConnection(networkManager: networkManager)
        viewModel.storage = SQLiteLocalStorage()
        getAllPosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationControllerAppearance()
        setupSegmentedControlAppearance()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
}

extension MyMessagesVC: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            if let allPost = allPosts, allPost.count != 0 {
                emptyState.isHidden = true
                dataView.isHidden = false
                return allPost.count
            } else {
                emptyState.isHidden = false
                dataView.isHidden = true
                return 0
            }
        } else {
            if let favoritePosts = favoritePosts, favoritePosts.count != 0 {
                emptyState.isHidden = false
                dataView.isHidden = true
                return favoritePosts.count
            } else {
                emptyState.isHidden = true
                dataView.isHidden = false
                return 0
            }
        }
    }
}

extension MyMessagesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return allPosts?.count ?? 0
        } else {
            return favoritePosts?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.postDataCell.resource, for: indexPath) as! PostDataCell
        
        if segmentedControl.selectedSegmentIndex == 0 {
            cell.setup(isFavorite: false, description: allPosts?[indexPath.row].title ?? "")
        } else {
            cell.setup(isFavorite: false, description: favoritePosts?.description ?? "")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.loading(show: true)
        performSegue(withIdentifier: "toDetail", sender: nil)
//        generationsViewModel.getPokemonAvailableInGeneration(generationUrl: generations[indexPath.item].url) { itemsRes, error in
//            if let e = error {
//                let banner = NotificationBanner(title: "Error", subtitle: e.localizedDescription, style: .danger)
//                DispatchQueue.main.async {
//                    self.loading(show: false)
//                    banner.show()
//                }
//            } else if let items = itemsRes {
//                self.pokemonsInGeneration = items.pokemon_species
//            }
//            DispatchQueue.main.async {
//                self.loading(show: false)
//                self.categoriesCollectionView.deselectItem(at: indexPath, animated: false)
//                self.performSegue(withIdentifier: "goToSearch", sender: nil)
//                self.goToFav = false
//            }
//        }
    }
}
