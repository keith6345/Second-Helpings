//
//  Home.swift
//  CunyHackathon
//
//  Created by Keith Cornish on 4/28/18.
//  Copyright © 2018 Keith Cornish. All rights reserved.
//

import UIKit

class Home: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "Home"
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
        
    }
    
    @IBAction func pickUpBtnTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
        
    }

}
