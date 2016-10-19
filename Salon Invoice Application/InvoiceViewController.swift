//
//  InvoiceViewController.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 8/11/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

/*
*/
import UIKit

class InvoiceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var servArray     : [(service: String, price: Int)] = []
    var dateArray     : [String] = []
    var tip : Double = 0
    var total : Double = 0
    var technician : String = ""
    var marrClientData : NSMutableArray!
    
    let format = DateFormatter()
    var date = Date()
    var currentDate = ""
    
    var clientInfo : ClientInfo!
    
    @IBOutlet weak var clientNameLbl: UILabel!
    @IBOutlet weak var roomNumLbl: UILabel!
    
    @IBOutlet weak var techLbl: UILabel!
    
    @IBOutlet weak var tbInvoice: UITableView!
    
    @IBOutlet weak var dateTextView: UITextView!
    
    @IBOutlet weak var printButton: UIButton!
    
    @IBOutlet weak var companyDetails: UITextView!
    let defaults: UserDefaults = UserDefaults.standard
    
    var backColor = UIColor(red: (134/255.0), green: (144/255.0), blue: (255/255.0), alpha: 1)
    var backColor2 = UIColor(red: (134/255.0), green: (144/255.0), blue: (255/255.0), alpha: 0.75)
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.automaticallyAdjustsScrollViewInsets = false
        
        printButton.layer.cornerRadius = 10
        
        format.dateFormat = "MM/dd/YYYY"
        
        currentDate = format.string(from: date)
        
        tbInvoice.separatorColor = UIColor.clear
        
        clientNameLbl.text = "Client:  \(clientInfo.Name)"
        roomNumLbl.text = "Room Number: \(clientInfo.Room)"
        
        dateTextView.text! += "\n \(currentDate)"
        dateTextView.textColor = backColor
        
        techLbl.text! += " \(technician)"
        
        total += tip
        
        
        companyDetails.text = "\(defaults.string(forKey: "Company")!)\n\(defaults.string(forKey: "Address")!)\n\(defaults.string(forKey: "Phone")!)"
        
        companyDetails.textColor = backColor
        
        for i in 0 ..< servArray.count
        {
            total += Double(servArray[i].price)
        }
    }

    override func viewWillAppear(_ animated: Bool)
    {
        //self.getClientData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("Services: \(servArray.count + 2)")
        return servArray.count + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        tableView.delegate = self
        tableView.dataSource = self
    
        let cell:InvoiceCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! InvoiceCell
        
        if((indexPath as NSIndexPath).row == 0)
        {
            cell.serviceLbl.text = "Description"
            cell.dateLbl.text = "Date"
            cell.amountLbl.text = "Amount"
            cell.backgroundColor = backColor
        }
        else if((indexPath as NSIndexPath).row == servArray.count + 1)
        {
            cell.serviceLbl.text = ""
            cell.dateLbl.text = "Gratuity:"
            cell.amountLbl.text =  String(format: "$%.2f", tip)
            cell.backgroundColor = backColor2
        }
        else if((indexPath as NSIndexPath).row == servArray.count + 2)
        {
            cell.serviceLbl.text = ""
            cell.dateLbl.text = "Total:"
            
            cell.amountLbl.text = String(format: "$%.2f", total)
            cell.backgroundColor = backColor
        }
        else
        {
            cell.backgroundColor = UIColor.white
            
            cell.serviceLbl.text = servArray[(indexPath as NSIndexPath).row - 1].service
            
            var tempDate = dateArray[(indexPath as NSIndexPath).row - 1]
            
            let parseIndex = tempDate.index(tempDate.startIndex, offsetBy: 10)
            
            tempDate = tempDate.substring(to: parseIndex)
            
            cell.dateLbl.text = tempDate
            
            cell.amountLbl.text = String(format: "$%.2f", Double(servArray[(indexPath as NSIndexPath).row - 1].price))
        }
        
        return cell
    }

    @IBAction func printBtnClicked(_ sender: AnyObject)
    {
        
        printButton.alpha = 0
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let printView = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let printController = UIPrintInteractionController.shared
        
        let printInfo = UIPrintInfo(dictionary: nil)
        
        printInfo.outputType = UIPrintInfoOutputType.general
        
        printInfo.jobName = "FG Print"
        
        printController.printInfo = printInfo
        
        printController.printingItem = printView
        
        printController.present(animated: true, completionHandler: nil)
        
        printButton.alpha = 1

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
