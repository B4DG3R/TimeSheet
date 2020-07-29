//
//  SettingsViewController.swift
//  TimeSheetApp
//
//  Created by Matthew Hollyhead on 11/05/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import UIKit
import MessageUI

class SettingsViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var timeSheetBrain = TimeSheetBrain()
    var emailBrain = EmailBrain()
    var userEmail: String?
    var clearTimeSheet = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Get User Email
//        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationEmail(_:)), name: Notification.Name("emailSetSettings"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //sendEmail()
    }
    
    @IBAction func daysButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func clearWeekButtonPressed(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name("clearTimeSheetData"), object: clearTimeSheet)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addEmailButtonPressed(_ sender: Any) {

        //Send Email to addemail VC for Display purpose
        //NotificationCenter.default.post(name: Notification.Name("emailSetAddEmail"), object: userEmail)
        
        let emailVc = storyboard?.instantiateViewController(identifier: "addEmailVC") as! AddEmailViewController
        present(emailVc, animated: true)
    }
    
//    @objc func didGetNotificationEmail(_ notification: Notification) {
//        let emailText = notification.object as! String
//        emailBrain.setUserEmail(emailAddress: emailText)
//    }
    
//    func sendEmail() {
//        userEmail = emailBrain.getUserEmail()
//        print("Email settings VC - \(userEmail ?? "No Email Set")")
//    }
}
