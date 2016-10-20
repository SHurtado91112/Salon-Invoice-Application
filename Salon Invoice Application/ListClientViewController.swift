//
//  ListClientViewController.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 8/9/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class ListClientViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dArray = [Int]()
    var dDate  = [String]()
    
    var marrClientData : NSMutableArray!
    @IBOutlet weak var tbClientData: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tbClientData.backgroundView = nil
        tbClientData.backgroundColor = UIColor.clear
        tbClientData.separatorColor = UIColor.clear
        
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
        marrClientData = ModelManager.getInstance().getAllClientData()
        tbClientData.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return marrClientData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:ClientCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ClientCell
        let client:ClientInfo = marrClientData.object(at: (indexPath as NSIndexPath).row) as! ClientInfo
        
        cell.backgroundView = nil
        cell.backgroundColor = UIColor.clear
        
        cell.lblContent.text = "Name: \(client.Name)"
        cell.btnService.tag = (indexPath as NSIndexPath).row
        cell.btnRemove.tag = (indexPath as NSIndexPath).row
        return cell
    }

    
    @IBAction func serviceBtnPressed(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "serviceSegue", sender: sender)
    }
    
    @IBAction func removeBtnPressed(_ sender: AnyObject)
    {
        let btnDelete : UIButton = sender as! UIButton
        let selectedIndex : Int = btnDelete.tag
        
        let clientData: ClientInfo = marrClientData.object(at: selectedIndex) as! ClientInfo
        
        print("\(selectedIndex) & Client : \(clientData.Name)")
        
        dArray = UserDefaults.standard.object(forKey: "\(clientData.Name) Index") as? [Int] ?? [Int]()
        
        dDate  = UserDefaults.standard.object(forKey: "\(clientData.Name) Date") as? [String] ?? [String]()
        
        //action sheet for deletion of record
        let alert = UIAlertController(title: "Wait!", message: "Are you sure you want to delete this record?" as String, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Yes", style: .destructive)
        { _ in
            
            let isDeleted = ModelManager.getInstance().deleteClientData(clientData)
            if isDeleted {
                
                self.dArray.removeAll()
                self.dDate.removeAll()
                
                UserDefaults.standard.set(self.dArray, forKey: "\(clientData.Name) Index")
                UserDefaults.standard.set(self.dDate, forKey: "\(clientData.Name) Date")
                
                Util.invokeAlertMethod("", strBody: "Record deleted successfully.", delegate: nil)
            } else {
                Util.invokeAlertMethod("", strBody: "Error in deleting record.", delegate: nil)
            }
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if(segue.identifier == "serviceSegue")
        {
            let btnService : UIButton = sender as! UIButton
            let selectedIndex : Int = btnService.tag
            
            let viewController : ServicesViewController = segue.destination as! ServicesViewController
            viewController.clientData = marrClientData.object(at: selectedIndex) as! ClientInfo
        }
    }
    

}
