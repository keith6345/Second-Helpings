//
//  PendingPickUpCell.swift
//  CunyHackathon
//
//  Created by Keith Cornish on 4/29/18.
//  Copyright © 2018 Keith Cornish. All rights reserved.
//

import UIKit

class PendingPickUpCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileImgBorderView: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        containerView.layer.cornerRadius = 5
        // Set approval blur view
        statusBlurView.layer.cornerRadius = 5
        backgroundBlurView.layer.cornerRadius = 5
        
        // Set user image border view shadow.
        userImgBorderView.layer.cornerRadius = userImgBorderView.frame.height/2
        userImgBorderView.layer.borderWidth = 1
        userImgBorderView.layer.borderColor = UIColor.white.cgColor
        // userImgBorderView.layer.shadowColor = UIColor.black.cgColor
        // userImgBorderView.layer.shadowOffset = CGSize(width: 2, height: 2)
        // userImgBorderView.layer.shadowOpacity = 1
        userImgView.layer.cornerRadius = userImgView.frame.height/2
        
        usernameLbl.layer.shadowColor = UIColor.black.cgColor
        usernameLbl.layer.shadowOffset = CGSize(width: 1, height: 1)
        usernameLbl.layer.shadowOpacity = 1
        usernameLbl.layer.shadowRadius = 1
        
        
        // Set image gradient view.
        let gradientLayer = CAGradientLayer()
        let baseColor = UIColor.black
        let topColor = UIColor.clear
        let width = UIScreen.main.bounds.width + 5
        gradientLayer.frame = CGRect(x: 0, y: 0, width: width, height: 180)
        gradientLayer.colors = [topColor.cgColor, baseColor.cgColor]
        gradientLayer.locations = [0, 1]
        gradientView.layer.addSublayer(gradientLayer)
        
    }
    
}
