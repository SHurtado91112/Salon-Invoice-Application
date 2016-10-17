//
//  ServicesViewController.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 8/9/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//
//
//TO DO: Create dictionary with client name as key, to hold array of services
//
//

import UIKit

class ServicesViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var clientData : ClientInfo!
    var marrClientData : NSMutableArray!
    
    var serviceArray     = [String]()
    var priceArray       = [Int]()
    var selectPriceArray = [Int]()
    var dateArray        = [String]()
    var selectedArray    = [String]()
    
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
        
        format.dateFormat = "MM/dd/YYYY"
        
        textView.text! = "Selected Services: \n"
        picker.delegate = self
        picker.dataSource = self
        picker.showsSelectionIndicator = false
        
        serviceArray = ["Men's Haircut", "Beard or Mustache Trim", "Women's Haircut", "Women's Haircut, Shampoo", "Shampoo Only", "Shampoo & Set", "Shampoo, Blowdry, Style", "Shampoo, Cut, Style", "Color, Shampoo, Style", "Color, Shampoo, Cut, Style", "Permanent", "Highlights, Shampoo, Cut, Style", "Re-Comb", "Regular Manicure", "Pedicure", "French Manicure", "Deluxe Manicure", "Eyebrow Shaping", "Eyebrow Waxing", "Lip Waxing", "Face Waxing", "All Three Waxing"]
        
        priceArray = [15,5,20,25,5,20,20,35,45,55,65,65,5,14,25,16,18,7,7,7,10,18]
        
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
        dater.datePickerMode = .date
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
        let titleData = serviceArray[row] + " $" + String(priceArray[row])
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
    
    @IBAction func addBtnClicked(_ sender: AnyObject)
    {
        selectedArray.append(serviceArray[selectedRow])
        selectPriceArray.append(priceArray[selectedRow])
        dateArray.append(format.string(from: dater.date))
        
        textView.text! += "\n\(selectedArray[i])\n"
        i += 1
    }
    
    @IBAction func removeBtnClicked(_ sender: AnyObject)
    {
        textView.text! = "Selected Services: \n"
        
        if(selectedArray.count > 0)
        {
            selectedArray.removeLast()
            selectPriceArray.removeLast()
            dateArray.removeLast()
            i -= 1
            
            if(selectedArray.count != 0)
            {
                for index in (0 ... (selectedArray.count-1))
                {
                    textView.text! += "\n\(selectedArray[index])\n"
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
            viewController.priceArray = self.selectPriceArray
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
