//
//  ViewController.swift
//  iBuy
//
//  Created by Camilo Jimenez on 3/08/21.
//

import UIKit
import NotificationBannerSwift
class SelectCountryVC: UIViewController {
    
    @IBOutlet weak var countryTable: UITableView!
    @IBOutlet weak var continueButton: UIButton!
    fileprivate lazy var countries = [CountryModel]()
    fileprivate let countryViewModel = CountriesVM()
    var dismiss: Bool = false
    lazy var selectedCountry: CountryModel? = nil {
        didSet {
            guard let country = selectedCountry else { return }
            saveCountry(country)
        }
    }
    
    fileprivate func saveCountry(_ country: CountryModel) {
        do {
            try countryViewModel.saveSelectedCountry(country)
        } catch {
            let banner = NotificationBanner(title: "Error", subtitle: error.localizedDescription, style: .danger)
            DispatchQueue.main.async {
                banner.show()
            }
        }
    }
    
    fileprivate func countryTableConf() {
        let nib = UINib(nibName: Constants.CellIdentifier.countryCell, bundle: nil)
        countryTable.register(nib, forCellReuseIdentifier: Constants.CellIdentifier.countryCell)
        countryTable.dataSource = self
        countryTable.delegate = self
        countryTable.separatorStyle = .none
        countryTable.showsVerticalScrollIndicator = false
        countryTable.backgroundColor = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        countryTableConf()
        countryViewModel.getCountries { countryRes, error in
            if let e = error {
                let banner = NotificationBanner(title: "Error", subtitle: e.localizedDescription, style: .danger)
                DispatchQueue.main.async {
                    banner.show()
                }

            } else if let countries = countryRes {
                self.countries = countries
                self.countryTable.reloadData()
            }
        }
    }
    
    @IBAction func continueButtonAction(_ sender: UIButton) {
        if !dismiss {
            self.performSegue(withIdentifier: "goToDashboard", sender: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    private func enableContinueButton() {
        self.continueButton.backgroundColor = Constants.CustomColors.green
        self.continueButton.setTitleColor(Constants.CustomColors.mintGreen, for: .normal)
        self.continueButton.setTitleColor(UIColor.lightGray, for: .disabled)
    }
}

extension SelectCountryVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifier.countryCell, for: indexPath) as! CountryCell
        cell.setup(countryTitle: countries[indexPath.row].name, flagImage: UIImage(named: countries[indexPath.row].id)!)
        
        return cell
    }
}

extension SelectCountryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountry = countries[indexPath[1]]
        self.continueButton.isEnabled = true
        self.continueButton.backgroundColor = Constants.CustomColors.green
    }
}
