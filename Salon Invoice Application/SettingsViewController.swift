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
