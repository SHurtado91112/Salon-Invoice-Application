//
//  SettingsViewController.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 9/9/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var compTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    let defaults: UserDefaults = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        //background gradient///////////
        let topColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 0.5)
        
        let bottomColor = UIColor(red: (228/255.0), green: (213/255.0), blue: (255/255.0), alpha: 0.9)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        ///////////////////////////////
        
        
        compTextField.text =     defaults.string(forKey: "Company")
        addressTextField.text =     defaults.string(forKey: "Address")
        phoneTextField.text =     defaults.string(forKey: "Phone")
        
        compTextField.layer.cornerRadius = 10
        addressTextField.layer.cornerRadius = 10
        phoneTextField.layer.cornerRadius = 10
        saveBtn.layer.cornerRadius = 10

    }

    @IBAction func savePressed(_ sender: AnyObject)
    {
        Util.invokeAlertMethod("", strBody: "Settings saved.", delegate: nil)
        defaults.set(compTextField.text, forKey: "Company")
        defaults.set(addressTextField.text, forKey: "Address")
        defaults.set(phoneTextField.text, forKey: "Phone")
        
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
