//
//  Prueba.swift
//  iBuy
//
//  Created by Camilo Jimenez on 6/08/21.
//

import UIKit

class MeowMeowVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyState: UIView!
    @IBOutlet weak var dataView: UIView!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var blockBackground: UIView!
    
    fileprivate var viewModel = MeowMeowVM()
    fileprivate var allCats: [DataModel]?
    fileprivate var seletedCat: DataModel?
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: CellIdentifiers.catDataCell.resource, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CellIdentifiers.catDataCell.resource)
        tableView.delegate = self
        tableView.dataSource = self
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
    
    fileprivate func getAllCats() {
        self.loading(show: true)
        self.allCats = viewModel.getAllStoredCats()
        DispatchQueue.main.async {
            if self.allCats?.count == 0 {
                self.emptyState.isHidden = false
                self.tableView.isHidden = true
            }

            self.tableView.reloadData()
            self.loading(show: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.storage = SQLiteLocalStorage()
        getAllCats()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let vc = segue.destination as! DetailItemVC
            vc.selectedPost = self.seletedCat
        }
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
        return allCats?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.catDataCell.resource, for: indexPath) as! CatDataCell
        
        let cat = allCats?[indexPath.row]
        cell.setup(isFavorite: cat?.like ?? false, catData: cat!.catInfo, interactedDate: cat!.dateInteraction)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.loading(show: true)
        self.seletedCat = allCats?[indexPath.row]
        self.loading(show: false)
        performSegue(withIdentifier: "toDetail", sender: nil)
    }
}
