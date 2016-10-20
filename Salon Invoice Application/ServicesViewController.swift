//
//  ServicesViewController.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 8/9/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//
//

import UIKit

class ServicesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate
{

    let def = UserDefaults.standard
    var defArray         = [Int]()
    var defDate          = [String]()
    
    var clientData : ClientInfo!
    var marrClientData : NSMutableArray!
    
    var serviceArray     = [(service: String, price: Int)]()
    var selectedArray    = [(service: String, price: Int)]()
    var dateArray        = [String]()
    
    
    var format = DateFormatter()
    
    var selectedRow = 0
    var tipAmount = 0.0
    var i = 0
    
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var dater: UIDatePicker!
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    
    @IBOutlet weak var tipTextField: UITextField!
    
    @IBOutlet weak var technicianTextField: UITextField!
    
    @IBOutlet weak var invoiceBtn: UIButton!
    
    var textColor = UIColor(red: (134/255.0), green: (144/255.0), blue: (255/255.0), alpha: 1)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tipTextField.delegate = self
        technicianTextField.delegate = self
        
        format.dateFormat = "MM/dd/YYYY, hh:mm a"
        
        textView.text! = "Selected Services: \n"
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = false
        
        serviceArray = [("Men's Haircut", 15), ("Beard or Mustache Trim", 5), ("Women's Haircut", 20), ("Women's Haircut, Shampoo", 25), ("Shampoo Only", 5), ("Shampoo & Set", 20), ("Shampoo, Blowdry, Style", 20), ("Shampoo, Cut, Style", 35), ("Color, Shampoo, Style", 45), ("Color, Shampoo, Cut, Style", 55), ("Permanent", 65), ("Highlights, Shampoo, Cut, Style", 65), ("Re-Comb", 5), ("Regular Manicure", 14), ("Pedicure", 25), ("French Manicure", 16), ("Deluxe Manicure", 18), ("Eyebrow Shaping", 7), ("Eyebrow Waxing", 7), ("Lip Waxing", 7), ("Face Waxing", 10), ("All Three Waxing", 18)]
        
        defArray = def.object(forKey: "\(clientData.Name) Index") as? [Int] ?? [Int]()
        defDate  = def.object(forKey: "\(clientData.Name) Date") as? [String] ?? [String]()
        
        loadServices()
        
        addBtn.layer.cornerRadius = 10
        removeBtn.layer.cornerRadius = 10
        invoiceBtn.layer.cornerRadius = 10
        tipTextField.layer.cornerRadius = 10
        technicianTextField.layer.cornerRadius = 10
        
        let topColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 1)
        
        let bottomColor = UIColor(red: (228/255.0), green: (213/255.0), blue: (255/255.0), alpha: 1)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        // Do any additional setup after loading the view.
        
        dater.setValue(textColor, forKeyPath: "textColor")
        dater.datePickerMode = .countDownTimer
        dater.datePickerMode = .dateAndTime
        dater.minuteInterval = 5
        
    }

    //03 textfield func for the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    {
        let titleData = serviceArray[row].service + " $" + String(serviceArray[row].price)
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16, weight: UIFontWeightUltraLight),NSForegroundColorAttributeName:textColor])
        return myTitle
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return serviceArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedRow = row
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        
        pickerView.subviews.forEach({
            
            $0.isHidden = $0.frame.height == 0.5
        })
        return 1
    }
    
    func loadServices()
    {
        if(defArray.count > 0)
        {
            for index in (0...defArray.count-1)
            {
                selectedArray.append(serviceArray[defArray[index]])
                
                textView.text! += "\n\(selectedArray[index].service)\n"
                
                dateArray.append(defDate[index])
                i += 1
            }
        }
    }
    
    @IBAction func addBtnClicked(_ sender: AnyObject)
    {
        selectedArray.append(serviceArray[selectedRow])
        
        print(dater.date)
        print(format.string(from: dater.date))
        dateArray.append(format.string(from: dater.date))
        defArray.append(selectedRow)
        defDate.append(dateArray[i])
        def.set(defArray, forKey: "\(clientData.Name) Index")
        def.set(defDate, forKey: "\(clientData.Name) Date")
        
        textView.text! += "\n\(selectedArray[i].service)\n"
        i += 1
    }
    
    @IBAction func removeBtnClicked(_ sender: AnyObject)
    {
        textView.text! = "Selected Services: \n"
        
        if(selectedArray.count > 0)
        {
            selectedArray.removeLast()
            dateArray.removeLast()
            defArray.removeLast()
            defDate.removeLast()
            def.set(defArray, forKey: "\(clientData.Name) Index")
            def.set(defDate, forKey: "\(clientData.Name) Date")
            
            i -= 1
            
            if(selectedArray.count != 0)
            {
                for index in (0 ... (selectedArray.count-1))
                {
                    textView.text! += "\n\(selectedArray[index].service)\n"
                }
            }
        }
    }
    
    @IBAction func invoiceBtnClicked(_ sender: AnyObject)
    {
        print("ADDED \(tipTextField.text!)")
        if(tipTextField.text != nil)
        {
            tipAmount = NSString(string: tipTextField.text!).doubleValue
        }
        else
        {
            tipAmount = 0.00
        }
        
        
        
        self.performSegue(withIdentifier: "invoiceSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "invoiceSegue")
        {
            let viewController : InvoiceViewController = segue.destination as! InvoiceViewController
            
            viewController.servArray = self.selectedArray
            viewController.dateArray = self.dateArray
            print("ending tip \(self.tipAmount)")

            viewController.tip = self.tipAmount
            viewController.clientInfo = self.clientData
            viewController.technician = self.technicianTextField.text!
            print(self.clientData.Name)
            print(viewController.clientInfo.Name)
        
        }
        
    }
 

}
