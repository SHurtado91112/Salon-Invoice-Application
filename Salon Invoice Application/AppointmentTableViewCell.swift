//
//  AppointmentTableViewCell.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 10/18/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell
{
    @IBOutlet weak var clientLabel: UILabel!

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        btnDelete.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
