//
//  CountryViewController.swift
//  icaew
//
//  Created by Setiady Wiguna on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit

enum CountrySource {
    case contact
    case event
    case university
}

class CountryViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var countrySource: CountrySource!
    private var countries: [Country]?
    
    private let kCountryListCellIdentifier = "CountryListCell"
    
    convenience init(countrySource: CountrySource) {
        self.init(nibName: "CountryViewController", bundle: nil)
        self.countrySource = countrySource
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupView()
        self.loadData()
    }
    
    func setupView() {
        
        switch self.countrySource! {
        case .contact:
            self.setupNavigationBar(title: "ICAEW OFFICES IN SOUTH EAST ASIA")
    
        case .event:
            self.setupNavigationBar(title: "ICAEW EVENTS")
            
        case .university:
            self.setupNavigationBar(title: "ICAEW PARTNER UNIVERSITY")
        }
        
        self.collectionView.registerNib(CountryCell.nib(),
                                        forCellWithReuseIdentifier: kCountryListCellIdentifier)
    }
    
    // MARK: Data
    private func loadData() {
        self.showHUD()
        Country.retrieveCountries{(result) in
            switch result {
            case .Success(let countries):
                self.countries = countries
                self.collectionView.reloadData()
                
            case .Error(_):
                break
            }
            
            self.dismissHUD()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let countries = self.countries else {
            return 0
        }
        
        return countries.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCountryListCellIdentifier, forIndexPath: indexPath) as! CountryCell
        
        if let countries = self.countries {
            let country = countries[indexPath.row]
            
            cell.countryName.text = country.name
            cell.countryImage.sd_setImageWithURL(NSURL(string: country.imageURL))
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }

}
