//
//  HomeViewController.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 9/9/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var calendarButton: UIButton!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        let topColor = UIColor(red: (255/255.0), green: (255/255.0), blue: (255/255.0), alpha: 0.5)
        
        let bottomColor = UIColor(red: (228/255.0), green: (213/255.0), blue: (255/255.0), alpha: 0.9)
        
        let gradientColors: [CGColor] = [topColor.cgColor, bottomColor.cgColor]
        let gradientLocations: [Float] = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = gradientColors
        gradientLayer.locations = gradientLocations as [NSNumber]?
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        
        continueButton.layer.cornerRadius = 10
        
        calendarButton.layer.cornerRadius = 10
        settingsButton.layer.cornerRadius = 10
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueClicked(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "newClientSegue", sender: self)
    }
    
    @IBAction func calendarClicked(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "calendarSegue", sender: self)
        
    }
    
    @IBAction func settingsClicked(_ sender: AnyObject)
    {
        self.performSegue(withIdentifier: "settingSegue", sender: self)
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
