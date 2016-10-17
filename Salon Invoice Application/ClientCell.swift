//
//  ClientCell.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 8/9/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class ClientCell: UITableViewCell
{
    
    @IBOutlet weak var lblContent: UILabel!
    
    @IBOutlet weak var btnService: UIButton!
    
    @IBOutlet weak var btnRemove: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        btnService.layer.cornerRadius = 10
        btnRemove.layer.cornerRadius = 10
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


