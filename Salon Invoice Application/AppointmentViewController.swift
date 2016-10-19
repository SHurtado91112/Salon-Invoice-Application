//
//  AppointmentViewController.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 10/18/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class AppointmentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    var marrClientData : NSMutableArray!
    
    @IBOutlet weak var tbAppointments: UITableView!
    
    var month   : Int!
    var day     : Int!
    var year    : Int!
    var hourMin : String!
    
    let def = UserDefaults.standard
    var serviceArray = [Int]()
    var dateArray    = [String]()
    
    var clientInfo = ClientInfo()
    
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
    

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return marrClientData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        clientInfo = marrClientData.object(at: section) as! ClientInfo
        
        dateArray = def.object(forKey: "\(clientInfo.Name) Date") as? [String] ?? [String]()
        serviceArray = def.object(forKey:  "\(clientInfo.Name) Index") as? [Int] ?? [Int]()
        
        return serviceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:AppointmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellApp") as! AppointmentTableViewCell
//        let client:ClientInfo = marrClientData.object(at: (indexPath as NSIndexPath).row) as! ClientInfo
        
        cell.backgroundView = nil
        cell.backgroundColor = UIColor.clear
        
        hourMin = getTime(row: indexPath.row)
        
        cell.clientLabel.text = "\(clientInfo.Name)"
        cell.timeLabel.text = hourMin
        cell.btnDelete.tag = (indexPath as NSIndexPath).row
        return cell
    }

    func getTime(row: Int) -> String
    {
        var tempDate = dateArray[row]
        
        var parseIndex = tempDate.index(tempDate.startIndex, offsetBy: 12)
        tempDate = tempDate.substring(from: parseIndex)
        
        if(tempDate.characters.count%2 == 0)
        {
            let temp = tempDate
            tempDate = "0"
            tempDate += temp
        }
        
        parseIndex = tempDate.index(tempDate.startIndex, offsetBy: 2)
        let tempInt = Int(tempDate.substring(to: parseIndex))
        
        tempDate = tempDate.substring(from: parseIndex)
        
        var stringToBuild = ""
        print("Int parsed: \(tempInt)")
        
        if(tempInt! == 0)
        {
            stringToBuild = "12"
            stringToBuild += tempDate
            stringToBuild += " AM"
        }
        else if(tempInt! < 12)
        {
            stringToBuild += String(tempInt!)
            stringToBuild += tempDate
            stringToBuild += " AM"
        }
        else if(tempInt! == 12)
        {
            stringToBuild += String(tempInt!)
            stringToBuild += tempDate
            stringToBuild += " PM"
        }
        else
        {
            stringToBuild += String(tempInt! - 12)
            stringToBuild += tempDate
            stringToBuild += " PM"
        }
        
        print("Time : \(stringToBuild)")
        
        
        return stringToBuild
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
