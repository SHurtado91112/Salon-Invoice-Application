//
//  ModelManager.swift
//  Salon Invoice Application
//
//  Created by Steven Hurtado on 8/9/16.
//  Copyright © 2016 Steven Hurtado. All rights reserved.
//

import UIKit

let sharedInstance = ModelManager()

class ModelManager: NSObject
{
    var database: FMDatabase? = nil
    
    // This code is called at most once
    class func getInstance() -> ModelManager
    {
        if(sharedInstance.database == nil)
        {
            sharedInstance.database = FMDatabase(path: Util.getPath("Salon.sqlite"))
        }
        return sharedInstance
    }
    
    func addClientData(_ clientInfo: ClientInfo) -> Bool
    {
        sharedInstance.database!.open()
        
        let isInserted = sharedInstance.database!.executeUpdate("INSERT INTO client_info (Name, Phone, Address, Room) VALUES (?, ?, ?, ?)", withArgumentsIn: [clientInfo.Name, clientInfo.Phone, clientInfo.Address, clientInfo.Room])
        sharedInstance.database!.close()
        return isInserted
    }
    
    func updateClientData(_ clientInfo: ClientInfo) -> Bool {
        sharedInstance.database!.open()
        let isUpdated = sharedInstance.database!.executeUpdate("UPDATE client_info SET Name=?, Phone=?, Address=? WHERE RollNo=?", withArgumentsIn: [clientInfo.Name, clientInfo.Phone, clientInfo.Address, clientInfo.RollNo])
        sharedInstance.database!.close()
        return isUpdated
    }
    
    func deleteClientData(_ clientInfo: ClientInfo) -> Bool {
        sharedInstance.database!.open()
        let isDeleted = sharedInstance.database!.executeUpdate("DELETE FROM client_info WHERE RollNo=?", withArgumentsIn: [clientInfo.RollNo])
        sharedInstance.database!.close()
        return isDeleted
    }
    
    
    func getAllClientData() -> NSMutableArray {
        
        sharedInstance.database!.open()
        let resultSet: FMResultSet! = sharedInstance.database!.executeQuery("SELECT * FROM client_info", withArgumentsIn: nil)
        let marrClientInfo : NSMutableArray = NSMutableArray()
        if (resultSet != nil) {

            //retrieve values for table cells
            while resultSet.next()
            {

                let clientInfo : ClientInfo = ClientInfo()
                clientInfo.RollNo = resultSet.string(forColumn: "RollNo")
                clientInfo.Name = resultSet.string(forColumn: "Name")
                clientInfo.Phone = resultSet.string(forColumn: "Phone")
                clientInfo.Address = resultSet.string(forColumn: "Address")
                clientInfo.Room = resultSet.string(forColumn: "Room")
                //if values have not been set up yet (username/password created but no information created)
                //then ignore
                if(resultSet.string(forColumn: "Name") != "")
                {
                    marrClientInfo.add(clientInfo)
                }
            }
        }
        sharedInstance.database!.close()
        
        return marrClientInfo
    }
}

