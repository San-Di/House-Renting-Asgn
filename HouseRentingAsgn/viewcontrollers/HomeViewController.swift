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
    
    let menuList = ["Top Collection", "Near me", "Low to High price"]
    
    @IBOutlet weak var menuCollectionView: UICollectionView!
    
    @IBOutlet weak var houseListTableView: UITableView!
    @IBOutlet weak var txtSearchField: UITextField!
    
    @IBOutlet weak var viewSearchField: UIView!
    
    let numberOfItemPerRow: CGFloat = 3
    let spacingPerItem: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getHouseList()
        txtSearchField.borderStyle = .none
        menuCollectionView.delegate = self
        menuCollectionView.dataSource = self
        
        houseListTableView.delegate = self
        houseListTableView.dataSource = self
        
        houseListTableView.register(UINib(nibName: String(describing: HouseItemTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: HouseItemTableViewCell.self))
        
        menuCollectionView.register(UINib(nibName: String(describing: MenuItemCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: MenuItemCollectionViewCell.self))
        
        let totalPadding: CGFloat = spacingPerItem * (numberOfItemPerRow + 1)
        
        let itemWidth: CGFloat = ( self.view.bounds.width  - totalPadding ) / numberOfItemPerRow
        let itemHeight: CGFloat = 100
        let layout = menuCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 10
        
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        menuCollectionView.isScrollEnabled = false
    }
  
    private func getHouseList() {
        HouseModel.shared().apiGetHouseList(success: {
            print("success")
            self.houseListTableView.reloadData()
        }) { (err) in
            print("err \(err)")
        }
    }

}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let menuItem = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MenuItemCollectionViewCell.self), for: indexPath ) as! MenuItemCollectionViewCell
        menuItem.mData = menuList[indexPath.row]
        return menuItem
    }
    
}

extension HomeViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        
        
        let cell = collectionView.cellForItem(at: indexPath) as! MenuItemCollectionViewCell
        cell.labelMenuItem.textColor = UIColor.black
        cell.viewMenuIndicator.backgroundColor = #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
        collectionView.deselectItem(at: indexPath, animated: true)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MenuItemCollectionViewCell
        cell.labelMenuItem.textColor = UIColor.lightGray
        cell.viewMenuIndicator.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
    }
}

extension HomeViewController: UITableViewDelegate{
    
}

extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HouseModel.shared().houseResponse.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HouseItemTableViewCell.self), for: indexPath) as! HouseItemTableViewCell
        cell.house = HouseModel.shared().houseResponse.data?[indexPath.row]
        print("House \(cell.house)" )
        cell.delegate = self
        return cell
    }
    
    
}


extension HomeViewController: HouseListItemActionDelegate{
    func onClickHouseItemDetail(data: HouseVO?) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: HouseRentDetailViewController.identifier) as! HouseRentDetailViewController
        
        vc.mHouse = data
        self.present(vc, animated: true)
        
    }
}

