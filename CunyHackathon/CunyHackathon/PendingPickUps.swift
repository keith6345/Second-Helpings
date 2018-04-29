//
//  PendingPickUps.swift
//  CunyHackathon
//
//  Created by Keith Cornish on 4/29/18.
//  Copyright © 2018 Keith Cornish. All rights reserved.
//

import UIKit

class PendingPickUps: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 5
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PendingPickUpCell
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        let trash = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            let alertTitle = "Cancel Pending Pick-up"
            let alertMessage = "Are you sure you would like to cancel this pending Pick-up?"
            
            // Alert.
            let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
            
            // Alert action delete request
            alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                
                
            }))
            
            // Alert action to cancel delete
            alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: {(action:UIAlertAction!) in
                
                
            }))
            
            // Present alertController.
            self.present(alertController, animated: true, completion: nil)
            
        }
        
        trash.backgroundColor = .red
        
        return [trash]
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return CGFloat(200)
        
    }

}
