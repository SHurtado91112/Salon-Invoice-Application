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
    var verifiedArray  : [String] = []
    @IBOutlet weak var tbAppointments: UITableView!
    
    var month   = ""
    var day     = ""
    var year    = ""
    var hourMin : String = ""
    
    let def = UserDefaults.standard
    var selectedArray = [Int]()
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
        print("Clients: \(marrClientData.count)")
        return marrClientData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        clientInfo = marrClientData.object(at: section) as! ClientInfo
     
        dateArray = def.object(forKey: "\(clientInfo.Name) Date") as? [String] ?? [String]()
        selectedArray = def.object(forKey:  "\(clientInfo.Name) Index") as? [Int] ?? [Int]()
        
        print("\nSection: \(section)")
        print("Name: \(clientInfo.Name)")
        
        verifiedArray = getVerified()
        
        print("Array Count: \(verifiedArray.count)\n")
        
        return verifiedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:AppointmentTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellApp") as! AppointmentTableViewCell
        
        clientInfo = marrClientData.object(at: (indexPath as NSIndexPath).section) as! ClientInfo
        
        dateArray = def.object(forKey: "\(clientInfo.Name) Date") as? [String] ?? [String]()
        selectedArray = def.object(forKey:  "\(clientInfo.Name) Index") as? [Int] ?? [Int]()
        
        verifiedArray = getVerified()
        
        if(verifiedArray.count > 0)
        {
            print("verified count: \(verifiedArray.count)")
            
            for i in (0...verifiedArray.count-1)
            {
                print("\(verifiedArray[i])")
            }
        }
        
        cell.backgroundView = nil
        cell.backgroundColor = UIColor.clear
        
        hourMin = getTime(row: indexPath.row)
        
        cell.clientLabel.text = "\(clientInfo.Name)"
        cell.timeLabel.text = hourMin
        cell.btnDelete.tag = (indexPath as NSIndexPath).row
        return cell
    }

    func getVerified() -> [String]
    {
        var verified = [String]()
        
        if(dateArray.count > 0)
        {
            
            for i in (0...dateArray.count-1)
            {
                //month checking
                var monthString = dateArray[i]
                var parseIndex = monthString.index(monthString.startIndex, offsetBy: 2)
                monthString = monthString.substring(to: parseIndex)
                
                //day checking
                var dayString = dateArray[i]
                parseIndex = dayString.index(parseIndex, offsetBy: 1)
                dayString = dayString.substring(from: parseIndex)
                parseIndex = dayString.index(dayString.startIndex, offsetBy: 2)
                dayString = dayString.substring(to: parseIndex)
                
                //year checking
                var yearString = dateArray[i]
                parseIndex = yearString.index(yearString.startIndex, offsetBy: 6)
                yearString = yearString.substring(from: parseIndex)
                parseIndex = yearString.index(yearString.startIndex, offsetBy: 4)
                yearString = yearString.substring(to: parseIndex)
                
                if(monthString == self.month && dayString == self.day && yearString == self.year)
                {
                    verified.append(dateArray[i])
                }
                
            }
        }
        
        return verified
    }
    
    func getTime(row: Int) -> String
    {
        var tempDate = verifiedArray[row]
        
        let parseIndex = tempDate.index(tempDate.startIndex, offsetBy: 12)
        tempDate = tempDate.substring(from: parseIndex)
        
        return tempDate
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
