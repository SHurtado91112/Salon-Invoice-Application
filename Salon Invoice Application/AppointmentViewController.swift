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

    var marrClientData     : NSMutableArray!
    var verifiedArray      : [(String, Int, String)] = []
    var totalScheduleArray : [(date: String, index: Int, name: String, section: Int)] = []
    
    @IBOutlet weak var tbAppointments: UITableView!
    
    var month   = ""
    var day     = ""
    var year    = ""
    var hourMin : String = ""
    
    let def = UserDefaults.standard
    var selectedArray = [Int]()
    var dateArray    = [String]()
    var serviceArray : [(String, Int)] = []
    
    var clientInfo = ClientInfo()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var servTemp = [String]()
        servTemp = def.object(forKey: "Service Array") as! [String]
        var priceTemp = [Int]()
        priceTemp = def.object(forKey: "Price Array") as! [Int]
        
        
        for i in (0...servTemp.count-1)
        {
            serviceArray.append((servTemp[i], priceTemp[i]))
        }
        
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
        self.getClientData()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getClientData()
    {
        marrClientData = NSMutableArray()
        totalScheduleArray = [(String, index: Int, name: String, section: Int)]()
        marrClientData = ModelManager.getInstance().getAllClientData()
        tbAppointments.reloadData()
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
                totalScheduleArray.append((verifiedArray[i].0,verifiedArray[i].1,verifiedArray[i].2, indexPath.section))
            }
        }
        
        cell.backgroundView = nil
        cell.backgroundColor = UIColor.clear
        
        hourMin = getTime(row: indexPath.row)
        
        cell.clientLabel.text = "\(clientInfo.Name)"
        cell.timeLabel.text = hourMin
        cell.serviceLabel.text = "\t\(serviceArray[verifiedArray[indexPath.row].1].0)"
        cell.btnDelete.tag = (indexPath as NSIndexPath).row
        return cell
    }

    func getVerified() -> [(String, Int, String)]
    {
        var verified = [(String, Int, String)]()
        
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
                    verified.append((dateArray[i], selectedArray[i], clientInfo.Name))
                }
                
            }
        }
        
        return verified
    }
    
    func getTime(row: Int) -> String
    {
        var tempDate = verifiedArray[row].0
        
        let parseIndex = tempDate.index(tempDate.startIndex, offsetBy: 12)
        tempDate = tempDate.substring(from: parseIndex)
        
        return tempDate
    }

    func indexToRemove(sec: Int, ind: Int, name: String) -> Int
    {
        print("Size: \(dateArray.count)")
        if(dateArray.count > 0)
        {
            for i in (0...dateArray.count-1)
            {
                
                if(totalScheduleArray.count > 0)
                {
                    for j in (0...totalScheduleArray.count-1)
                    {
                        print("\(totalScheduleArray[j].date) == \(dateArray[i])")
                        print("\(serviceArray[totalScheduleArray[j].index].0) == \(serviceArray[selectedArray[i]].0)")
                        print("\(totalScheduleArray[j].name) == \(name)")
                        print("\(totalScheduleArray[j].section) == \(sec)")

                        
                        if(totalScheduleArray[j].date == dateArray[i]
                            && serviceArray[totalScheduleArray[j].index].0 == serviceArray[selectedArray[i]].0
                            && totalScheduleArray[j].name == name
                            && totalScheduleArray[j].section == sec)
                        {
                            print("\n\nFOUND MATCH\n\n")
                            return i
                        }
                    }
                }
            }
        }
        
        return -1
    }
    
    @IBAction func deleteCell(_ sender: AnyObject)
    {
        
//        print(sender.superview??.superview)
        let btnDelete : UIButton = sender as! UIButton
        
        let cell = btnDelete.superview?.superview! as! AppointmentTableViewCell
        
        let indPath = tbAppointments.indexPath(for: cell)
        let section = indPath?.section
        let row     = btnDelete.tag
        
        
        let client = marrClientData[section!] as! ClientInfo
        print("\(client.Name)")
        
        for i in (0...totalScheduleArray.count-1)
        {
            print(totalScheduleArray[i])
        }
        
        selectedArray = UserDefaults.standard.object(forKey: "\(client.Name) Index") as? [Int] ?? [Int]()
        
        dateArray  = UserDefaults.standard.object(forKey: "\(client.Name) Date") as? [String] ?? [String]()
        
        //action sheet for deletion of record
        let alert = UIAlertController(title: "Wait!", message: "Are you sure you want to delete this record?" as String, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Yes", style: .destructive)
        { _ in
            
            let index = self.indexToRemove(sec: section!, ind: row, name: client.Name)
            if(index == -1)
            {
                Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
            }
            else
            {
                print("To be deleted: \(client.Name)\nWith service: \(self.selectedArray[index])\nand date of: \(self.dateArray[index])")
                self.selectedArray.remove(at: index)
                self.dateArray.remove(at: index)
                Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
            }
            
            UserDefaults.standard.set(self.selectedArray, forKey: "\(client.Name) Index")
            UserDefaults.standard.set(self.dateArray, forKey: "\(client.Name) Date")
            
            self.getClientData()
        }
        let action2 = UIAlertAction(title: "No", style: .default)
        { _ in
            Util.invokeAlertMethod("", strBody: "Record not deleted.", delegate: nil)
        }
        
        alert.addAction(action1)
        alert.addAction(action2)
        
        self.present(alert, animated: true){}
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
