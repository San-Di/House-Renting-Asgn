//
//  HouseRentDetailViewController.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/14/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit

class HouseRentDetailViewController: UIViewController {

    @IBOutlet weak var txtSearchField: UITextField!
    static let identifier = "HouseRentDetailViewController"
    override func viewDidLoad() {
        super.viewDidLoad()

       txtSearchField.borderStyle = .none
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
