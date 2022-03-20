//
//  Prueba.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import UIKit
import NotificationBannerSwift

class MeowMeowVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyState: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var blockBackground: UIView!
    
    fileprivate var viewModel = MeowMeowVM()
    fileprivate var allPosts: [BreedsModel]?
    fileprivate var seletedPost: BreedsModel?
    
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
    
//    fileprivate func getAllPosts() {
//        self.loading(show: true)
//        self.allPosts?.removeAll()
//        viewModel.getAllPosts { postsRes, error in
//            if let e = error {
//                DispatchQueue.main.async {
//                    let banner = NotificationBanner(title: "Error", subtitle: e.localizedDescription, style: .danger)
//                    self.loading(show: false)
//                        banner.show()
//                }
//            } else if let posts = postsRes {
//                self.allPosts = posts
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                    self.loading(show: false)
//                }
//            }
//        }
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()

        viewModel.storage = SQLiteLocalStorage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        setupNavigationControllerAppearance()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let vc = segue.destination as! DetailItemVC
            vc.selectedPost = self.seletedPost
        }
    }
    
    @IBAction func reloadData(_ sender: Any) {
        
    }
    @IBAction func clearData(_ sender: Any) {

    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {

    }
}

extension MeowMeowVC: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension MeowMeowVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPosts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.postDataCell.resource, for: indexPath) as! PostDataCell
        
        let post = allPosts?[indexPath.row]
        cell.setup(isFavorite: false, isReaded: false, description: post?.name ?? "")
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.loading(show: true)
        self.seletedPost = allPosts?[indexPath.row]
        self.loading(show: false)
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
}
