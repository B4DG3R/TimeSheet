//
//  EmailBrain.swift
//  TimeSheetApp
//
//  Created by Matthew Hollyhead on 18/05/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import UIKit

struct EmailBrain {
    
    var userEmail: UserEmail?
    
    let userEmailKey = "userEmailKey"
    
    mutating func setUserEmail(emailAddress: String) {
        userEmail = UserEmail(email: emailAddress)
        print("Email Set to \(userEmail?.email ?? "")") 
    }
    
    func getUserEmail() -> String {
        return userEmail?.email ?? "No Email"
    }
    
}
