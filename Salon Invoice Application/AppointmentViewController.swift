//
//  AppointmentViewController.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 10/18/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class AppointmentViewController: UIViewController
{

    var marrClientData : NSMutableArray!
    
    @IBOutlet weak var tbAppointments: UITableView!
    
    var month   : Int!
    var day     : Int!
    var year    : Int!
    var hourMin : String!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tbAppointments.backgroundView = nil
        tbAppointments.backgroundColor = UIColor.clear
        tbAppointments.separatorColor = UIColor.clear
        
        let topColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1)
        
        let bottomColor = UIColor(red: (228/255.0), green: (213/255.0), blue: (255/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func viewWillAppear(_ animated: Bool)
    {
//        self.getClientData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return marrClientData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:AppointmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellApp") as! AppointmentTableViewCell
        let client:ClientInfo = marrClientData.object(at: (indexPath as NSIndexPath).row) as! ClientInfo
        
        cell.backgroundView = nil
        cell.backgroundColor = UIColor.clear
        
        cell.clientLabel.text = "\(client.Name)"
//        cell.timeLabel.text = "\(time)"
        cell.btnDelete.tag = (indexPath as NSIndexPath).row
        return cell
    }



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
