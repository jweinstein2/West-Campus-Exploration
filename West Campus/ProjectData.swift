//
//  ProjectData.swift
//  West Campus
//
//  Created by Tom Chu on 11/7/15.
//  Copyright © 2015 ENAS118. All rights reserved.
//

import UIKit

class ProjectData: NSObject {
    var projectData = [Project]()
    
    override init() {
    }
    
    init(var inputString: String){
        super.init()
        
        if inputString != "" {
            
        inputString = inputString.substringToIndex(inputString.endIndex.predecessor())    
        inputString = inputString.stringByReplacingOccurrencesOfString("\\/", withString: "/")
        
        var projectArr = inputString.componentsSeparatedByString("}")
        projectArr.removeLast() //remove bc separating by end braces leaves an empty string at the end
        
        for var index = 0; index < projectArr.count; ++index{
            projectArr[index] = projectArr[index].substringFromIndex(projectArr[index].startIndex.advancedBy(2))
            let id = find(projectArr[index], element: "project_id")
            let title = find(projectArr[index], element: "title")
            let summary = find(projectArr[index], element: "summary")
            let link = find(projectArr[index], element: "link")
            let gpsLatitude : Double! = Double(find(projectArr[index], element: "gps_latitude"))
            let gpsLongitude : Double! = Double(find(projectArr[index], element: "gps_longitude"))
            let clue = find(projectArr[index], element: "clue")
            let action = find(projectArr[index], element: "action")
            let imageLink = find(projectArr[index], element: "photo")
            /*
            let forestry: Bool
            let sustainability: Bool
            let construction: Bool
            
            if find(projectArr[index], element: "forestry") == "1" {
                forestry = true
            }
            else{
                forestry = false
            }
            if find(projectArr[index], element: "sustainability") == "1" {
                sustainability = true
            }
            else{
                sustainability = false
            }
            if find(projectArr[index], element: "construction") == "1" {
                construction = true
            }
            else{
                construction = false
            }
            */
            //Need to handle errors if this doens't load or if certain elements arent there. We want to download as much data as possible
            let currentProject = Project.init(projectId: id, title: title, summary: summary, link: link, gpsLatitude: gpsLatitude, gpsLongitude: gpsLongitude, clue: clue, action: action, imageLink: imageLink/*, forestry: forestry, sustainability: sustainability, construction: construction*/)
            
            NSLog("image link: " + imageLink)
            
            projectData.append(currentProject)
            }
        }
        
    }
    
    func find (let project: String, element: String) -> String{
        var tokens = project.componentsSeparatedByString("\",\"")
        
        for var index = 0; index < tokens.count; ++index{
            
            var map = tokens[index].componentsSeparatedByString("\":\"")
            if map[0] == element {
                return map[1]
            }
        }
        NSLog("error")
        return "fail"
    }
}