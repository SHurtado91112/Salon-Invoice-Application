//
//  Util.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 8/9/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

//struct for current user and pass
struct Globals
{
}

extension UIView {
    func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

//class for utilities
class Util: NSObject
{
    
    class func getPath(_ fileName: String) -> String
    {
        
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL = documentsURL.appendingPathComponent(fileName)
        
        print("Your final DB path : \(fileURL.path)")
        
        return fileURL.path
    }
    
    class func copyFile(_ fileName: NSString)
    {
        let dbPath: String = getPath(fileName as String)
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: dbPath) {
            
            let documentsURL = Bundle.main.resourceURL
            let fromPath = documentsURL!.appendingPathComponent(fileName as String)
            
            var error : NSError?
            do {
                try fileManager.copyItem(atPath: fromPath.path, toPath: dbPath)
            } catch let error1 as NSError {
                error = error1
            }
            
            let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
            let action1 = UIAlertAction(title: "Okay", style: .default){ _ in}
            
            alert.addAction(action1)
            
            if (error != nil) {
                alert.title = "Error Occured"
                alert.message = error?.localizedDescription
            } else {
                alert.title = "Successfully Copied"
                alert.message = "Your database copied successfully"
            }
            
            let rootVC = UIApplication.shared.keyWindow?.rootViewController
            rootVC?.present(alert, animated: true){}
        }
    }
    
    class func invokeAlertMethod(_ strTitle: NSString, strBody: NSString, delegate: AnyObject?)
    {
        let alert = UIAlertController(title: strTitle as String, message: strBody as String, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Okay", style: .default){ _ in}
        
        alert.addAction(action1)
        
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        rootVC?.present(alert, animated: true){}
    }
    
    /*
     class func invokeDeletionAlertMethod(strTitle: NSString, strBody: NSString, delegate: AnyObject?) -> Int
     {
     let alert = UIAlertController(title: strTitle as String, message: strBody as String, preferredStyle: .ActionSheet)
     let action1 = UIAlertAction(title: "Yes", style: .Destructive)
     { _ in
     return 1
     }
     let action2 = UIAlertAction(title: "No", style: .Default)
     { _ in
     return -1
     }
     
     alert.addAction(action1)
     alert.addAction(action2)
     
     let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController
     rootVC?.presentViewController(alert, animated: true){}
     return 0
     }
     */
}
