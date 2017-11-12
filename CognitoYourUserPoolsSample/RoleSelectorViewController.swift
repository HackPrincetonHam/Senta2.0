//
//  RoleSelectorViewController.swift
//  CognitoYourUserPoolsSample
//
//  Created by 何幸宇 on 11/11/17.
//  Copyright © 2017 Dubal, Rohan. All rights reserved.
//

import UIKit

class RoleSelectorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func confirmBtnTapped(_ sender:UIButton){
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func chooseRoleBtnTapped(_ sender:UIButton){
        save_role_DDB(role: sender.currentTitle!, completion: {return})
    }
  
}
