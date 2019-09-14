//
//  ViewController.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/12/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    static let identifier = "HomeViewController"
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    @IBOutlet weak var houseListTableView: UITableView!
    
    let numberOfItemPerRow: CGFloat = 3
    let spacingPerItem: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieList()
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        houseListTableView.delegate = self
        houseListTableView.dataSource = self
        
        houseListTableView.register(UINib(nibName: String(describing: HouseItemTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HouseItemTableViewCell.self))
        
        menuCollectionView.register(UINib(nibName: String(describing: MenuItemCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MenuItemCollectionViewCell.self))
        
        let totalPadding: CGFloat = spacingPerItem * (numberOfItemPerRow + 1)
        
        let itemWidth: CGFloat = ( self.view.bounds.width  - totalPadding ) / numberOfItemPerRow
        let itemHeight: CGFloat = 100
        print("width \(itemWidth) height \(itemHeight)")
        let layout = menuCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 10
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        menuCollectionView.isScrollEnabled = false
    }
  
    private func getMovieList() {
//        self.showProgress(message: "Loading ... ")
        HouseModel.shared().apiGetHouseList(success: {
            print("success")
        }, failure: { (err) in
            print("error")
        })
    }

}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuItem = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MenuItemCollectionViewCell.self), for: indexPath ) as! MenuItemCollectionViewCell
        
        return menuItem
    }
    
}

extension HomeViewController: UICollectionViewDelegate{
    
}

extension HomeViewController: UITableViewDelegate{
    
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HouseItemTableViewCell.self), for: indexPath) as! HouseItemTableViewCell
        cell.house = HouseModel.shared().houseResponse.results?[indexPath.row] ?? HouseVO()
        cell.delegate = self
        return cell
    }
    
    
}


extension HomeViewController: HouseListItemActionDelegate{
    func onClickHouseItemDetail() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: HouseRentDetailViewController.identifier) as! HouseRentDetailViewController
        
        self.present(vc, animated: true)
        
    }
}

