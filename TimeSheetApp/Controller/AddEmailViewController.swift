//
//  addEmailVC.swift
//  TimeSheetApp
//
//  Created by Matthew Hollyhead on 18/05/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import UIKit

class AddEmailViewController: UIViewController {
    
    var emailBrain = EmailBrain()
    var userEmailSet: String?
    var emailDisplay = ""
    var dataReload = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //emailDisplay = userEmailSet ?? ""
        //userEmailLabel.text = "Email: \(emailDisplay)"
    }
    
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        //Sends user email to days VC when entered and saved
        NotificationCenter.default.post(name: Notification.Name("emailTextField"), object: emailTextField.text)
        dismiss(animated: true, completion: nil)
    
    }
}
