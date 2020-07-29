//
//  TimeSheetBrain.swift
//  TimeSheetApp
//
//  Created by Matthew Hollyhead on 14/05/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import UIKit
import MessageUI

struct TimeSheetBrain {
    
    var timeSheet: TimeSheet?
    
    func getDate() -> String {
        // get the current date and format it to dd/mm/yyyy
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let date = formatter.string(from: currentDateTime)
        
        return date
    }
    
    mutating func saveJob(jobDescription: String, hours: Double, jobCode: String) {
        
        let todaysDate = getDate()
        let jobDescription = jobDescription
        let hours = hours
        let jobCode = jobCode
        
        timeSheet = TimeSheet(todaysDate: todaysDate, jobDescription: jobDescription, hours: hours, jobCode: jobCode)
    }
    
    func getTimeSheetData() -> (String, String, String, String) {
        let date = timeSheet?.todaysDate ?? ""
        let jobDescription = timeSheet?.jobDescription ?? ""
        let hours = String(timeSheet?.hours ?? 0.0)
        let Jobcode = timeSheet?.jobCode ?? ""
        
        return (date, jobDescription, hours , Jobcode)
    }

    func addJobToListString() {
        
    }
    
    
    
}





