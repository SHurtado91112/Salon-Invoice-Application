//
//  NewClientViewController.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 8/9/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class NewClientViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var roomTextField: UITextField!
    
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var clientBtn: UIButton!
    
    let clientInfo: ClientInfo = ClientInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        addressTextField.delegate = self
        phoneTextField.delegate = self
        roomTextField.delegate = self
        
        let topColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 0.5)
        
        let bottomColor = UIColor(red: (228/255.0), green: (213/255.0), blue: (255/255.0), alpha: 0.9)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        nameTextField.text! = ""
        addressTextField.text! = ""
        phoneTextField.text! = ""
        
        nameTextField.layer.cornerRadius = 10
        addressTextField.layer.cornerRadius = 10
        phoneTextField.layer.cornerRadius = 10
        roomTextField.layer.cornerRadius = 10
        addBtn.layer.cornerRadius = 10
        
        clientBtn.layer.cornerRadius = 10
    }

    //03 textfield func for the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func addBtnClicked(_ sender: AnyObject)
    {
        if(nameTextField.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter name.", delegate: nil)
        }
        else if(addressTextField.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter address.", delegate: nil)
        }
        else if(phoneTextField.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter phone number.", delegate: nil)
        }
        else if(roomTextField.text == "")
        {
            Util.invokeAlertMethod("", strBody: "Please enter room number.", delegate: nil)
        }
        else
        {
           
                clientInfo.Name = nameTextField.text!
                clientInfo.Address = addressTextField.text!
                clientInfo.Phone = phoneTextField.text!
                clientInfo.Room = roomTextField.text!
            
                let isInserted = ModelManager.getInstance().addClientData(clientInfo)
                if isInserted
                {
                    self.performSegue(withIdentifier: "addSegue", sender: self)
                    Util.invokeAlertMethod("", strBody: "Record inserted successfully.", delegate: nil)
                    nameTextField.text! = ""
                    addressTextField.text! = ""
                    phoneTextField.text! = ""
                    roomTextField.text! = ""
                }
                else
                {
                    Util.invokeAlertMethod("", strBody: "Error in inserting record.", delegate: nil)
                }
            }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "addSegue")
        {
            let viewController : ServicesViewController = segue.destination as! ServicesViewController
            viewController.clientData = self.clientInfo
        }
    }
    

}
