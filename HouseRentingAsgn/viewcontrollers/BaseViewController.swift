//
//  BaseViewController.swift
//  HouseRentingAsgn
//
//  Created by Sandi on 9/15/19.
//  Copyright © 2019 Sandi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func showAlertDialog(message: String){
        let alert = UIAlertController(title: "Failed!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }

}
