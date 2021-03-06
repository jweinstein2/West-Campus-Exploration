//
//  MainModel.swift
//  West Campus
//
//  Created by jared weinstein on 11/7/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//
import UIKit
import Foundation

class MainModel : NSObject, NSURLConnectionDelegate{
    lazy var data = NSMutableData()
    var jsonData = NSArray()
    var projects : ProjectData!
    var currentProject : Int!
    var scavengerHuntAvailable: Bool!
    var scavengerHuntIsSetUp: Bool!
    var hunt: ScavengerHunt!
    var prefs : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var key = "savedjsonarray"

    override init(){
        super.init()
        
        startConnection()
    }
    
    func getCurrentProject() -> Project{
        return projects.projectData[currentProject]
    }
    
    
    //This method is called when the application fails to connect to the database
    func loadNSUserDefaults(){
        let json = prefs.objectForKey(key) as! NSArray
        if json.count == 0{
            NSLog("Retrieving NSUserDefaults")
            NSLog(String(jsonData))
            projects = ProjectData(inputArray: jsonData)
            prefs.synchronize()
            //Previously saved defaults are availible
            
        }else{
            NSLog("No Data found. Unable to continue.")
            //No data is found. Need to alert the user that the app is unusable until we connect to data
            
            _ = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("startConnection"), userInfo: nil, repeats: false)
        }
    }
    
    func downloadData(){
        projects = ProjectData(inputArray: jsonData)
        
        if projects.projectData.count == 0 {        //set availability of scavenger hunt
            scavengerHuntAvailable = false
        }
        else {
            scavengerHuntAvailable = true
        }
        
        //Save Data as Defaults
        NSLog(String(jsonData))
        NSLog("Data saved to NSUserDefaults")
        prefs.setObject(jsonData, forKey: key)
        prefs.synchronize()
    }
    
    //JSON CONNECTION METHODS BELOW
    
    func startConnection(){
        let urlPath: String = "http://contripity.net/wildwest/researchprojects.php" //this needs to be changed to the new website
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSURLRequest = NSURLRequest(URL: url)
        let connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)!
        connection.start()
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        NSLog("Error: unable to download JSON string")
        NSLog(String(error))
        self.loadNSUserDefaults()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data.appendData(data)
    }
    
    func buttonAction(sender: UIButton!){
        startConnection()
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        scavengerHuntIsSetUp = false
        currentProject = 0;
        
        var failed : Bool = false
        // throwing an error on the line below (can't figure out where the error message is)
        do{
             jsonData = try (NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers) as? NSArray)!
        }catch{
            NSLog("ERROR: Line 21 of Main Model - Failed to download the contents of json from website")
            failed = true
            self.loadNSUserDefaults()
        }
        
        if failed == false{
            downloadData()
        }
    }
}
