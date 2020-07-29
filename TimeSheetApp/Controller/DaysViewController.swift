//
//  ViewController.swift
//  TimeSheetApp
//
//  Created by Matthew Hollyhead on 10/05/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import UIKit
import MessageUI

class DaysViewController: UIViewController {
        
    var emailBrain = EmailBrain()
    var timeSheetBrain = TimeSheetBrain()
    
    let defaults = UserDefaults.standard
    
    var dayPressed: String?
    var date: String?
    var jobDescription: String?
    var hours: Double?
    var yNumber: String?
    var jobCode: String?
    var userEmail: String?
    var timeSheetExport: [String] = []
    var clearData = false
    var csvString: String?
    
    var monHours  = 0.0
    var tueHours  = 0.0
    var wedHours  = 0.0
    var thurhours = 0.0
    var friHours  = 0.0
    var satHours  = 0.0
    var sunHours  = 0.0
    
    var dataRe = false
    
    struct keys {
        //Keys for saving data
        static let timeSheetExport  = "timeSheetExport"
        static let userEmail        = "userEmail"
        static let monHours         = "mondayHours"
        static let tuesHours        = "tuesdayHours"
        static let wedHours         = "wednesdayHours"
        static let thusHours        = "thursdayHours"
        static let friHours         = "fridayHours"
        static let satHours         = "saturdayHours"
        static let sunHours         = "sundayHours"
        static let clearTimeSheet   = "clearTimeSheet"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkForSavedData()
        
        // gets job data from addEditTaksVC
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationJobDescription(_:)), name: Notification.Name("jobDescriptionTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationHours(_:)), name: Notification.Name("hoursTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationYNumber(_:)), name: Notification.Name("yNumberTextField"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationJobCode(_:)), name: Notification.Name("jobCodeTextField"), object: nil)
        
        
        //Get User Email
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationEmail(_:)), name: Notification.Name("emailTextField"), object: nil)
        
        //  tells func didGetNotificationReloadData there is data to be appended to addJobToListString() and calls this function
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationReloadData(_:)), name: Notification.Name("ReloadData"), object: nil)
        
        // tells func didGetNotificationClearData to clear all time sheet data
        NotificationCenter.default.addObserver(self, selector: #selector(didGetNotificationClearData(_:)), name: Notification.Name("clearTimeSheetData"), object: nil)
        
        date = timeSheetBrain.getDate()
        print("Days View Controller did load")
    }

    @IBOutlet weak var mondayLabel: UIButton!
    @IBOutlet weak var tuesdayLabel: UIButton!
    @IBOutlet weak var wednesdayLabel: UIButton!
    @IBOutlet weak var thursdayLabel: UIButton!
    @IBOutlet weak var fridayLabel: UIButton!
    @IBOutlet weak var saturdayLabel: UIButton!
    @IBOutlet weak var sundayLabel: UIButton!
    
    @IBAction func dayButtonPressed(_ sender: UIButton) {
        // sets dayPressed to which ever day button pressed to be sent to
        // task VC for day title label
        if sender.currentTitle == "     Monday | Hours : " {
            dayPressed = "Monday"
        } else if sender.currentTitle == "     Tuesday | Hours : " {
            dayPressed = "Tuesday"
        } else if sender.currentTitle == "     Wednesday | Hours : " {
            dayPressed = "Wednesday"
        } else if sender.currentTitle == "     Thursday | Hours : " {
            dayPressed = "Thursday"
        } else if sender.currentTitle == "     Friday | Hours : " {
            dayPressed = "Friday"
        } else if sender.currentTitle == "     Saturday | Hours : " {
            dayPressed = "Saturday"
        } else {
            dayPressed = "Sunday"
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        // Opens addEditTask View Controller Modually
        let vc = storyboard?.instantiateViewController(identifier: "addEditTasksVC") as! AddEditTasksViewController
        present(vc, animated: true)
        
        // Reload Data Bool, is made true when data is sent back from addEditTaskVC
        dataRe = false
    }
    
    @objc func didGetNotificationJobDescription(_ notification: Notification) {
        let descriptionText = notification.object as! String
        jobDescription = descriptionText
        print("Job Description - \(jobDescription!)")
    }
    
    @objc func didGetNotificationHours(_ notification: Notification) {
        let hoursText = notification.object as! String
        hours = Double(hoursText)
        print("hours - \(hours!)")
    }
    
    @objc func didGetNotificationYNumber(_ notification: Notification) {
        let yNumberText = notification.object as! String
        yNumber = yNumberText
        print("y number - \(yNumber!)")
    }
    
    @objc func didGetNotificationJobCode(_ notification: Notification) {
        let jobCodeText = notification.object as! String
        jobCode = jobCodeText
        print("job Code - \(jobCode!)")
    }
    
    @objc func didGetNotificationEmail(_ notification: Notification) {
        let emailText = notification.object as! String
        emailBrain.setUserEmail(emailAddress: emailText)
        saveData()
        
    }
    
    @objc func didGetNotificationReloadData(_ notification: Notification) {
        dataRe = notification.object as! Bool
        
        if dataRe == true {
            print("View Controller got Reloaded")
            
            addJobToListString()
            whichDayOfTheWeek()
            setHoursOnDaysVC()
            print(whichDayOfTheWeek())
            saveData()
        }
        
    }
    
    @objc func didGetNotificationClearData(_ notification: Notification) {
        clearData = notification.object as! Bool
        print(clearData)
        
        if clearData == true {
            clearTimeSheetData()
        }
    }
    
    @IBAction func settingButtonPressed(_ sender: UIButton) {
        
        //userEmail = emailBrain.getUserEmail()
        
        //Send Email Back
        //NotificationCenter.default.post(name: Notification.Name("emailSetSettings"), object: userEmail)
        
        let settingsVc = storyboard?.instantiateViewController(identifier: "settingsVC") as! SettingsViewController
        present(settingsVc, animated: true)
    
    }
    
    
    
    func addJobToListString() {
        
        // Array contains variable data to be added to export list
        // \n in item 3 of array to append onto new line
        let addToTimeSheet = ["\n\(date!)", jobDescription!, String(hours!), yNumber!, jobCode!,]
        
        // Appends contents of addTimeSheet to timeSheetExport
        timeSheetExport.append(contentsOf: addToTimeSheet)
        
        // Prints export array to console
        print (timeSheetExport)
    }
    
    func whichDayOfTheWeek() -> String {
        let dayNumber = Calendar.current.component(.weekday, from: Date())
        
        switch dayNumber {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Error no day found"
        }
    }
    
    func setHoursOnDaysVC() {
       
        if whichDayOfTheWeek() == "Sunday" {
            sunHours += hours ?? 0.0
//            sundayLabel.setTitle("     Sunday | Hours : \(sunHours)", for: .normal)

        } else if whichDayOfTheWeek() == "Monday" {
            monHours += hours ?? 0.0
//            mondayLabel.setTitle("     Monday | Hours : \(monHours)", for: .normal)

        } else if whichDayOfTheWeek() == "Tuesday" {
            tueHours += hours ?? 0.0
//            tuesdayLabel.setTitle("     Tuesday | Hours : \(tueHours)", for: .normal)

        } else if whichDayOfTheWeek() == "Wednesday" {
            wedHours += hours ?? 0.0
//            wednesdayLabel.setTitle("     Wednesday | Hours : \(wedHours)", for: .normal)

        } else if whichDayOfTheWeek() == "Thursday" {
            thurhours += hours ?? 0.0
//            thursdayLabel.setTitle("     Thursday | Hours : \(thurhours)", for: .normal)

        } else if whichDayOfTheWeek() == "Friday" {
            friHours += hours ?? 0.0
//            fridayLabel.setTitle("     Friday | Hours : \(friHours)", for: .normal)

        } else if whichDayOfTheWeek() == "Saturday" {
            satHours += hours ?? 0.0
//            saturdayLabel.setTitle("     Saturday | Hours : \(satHours)", for: .normal)
        }
        
        sundayLabel.setTitle(" Sunday | Hours : \(sunHours)", for: .normal)
        mondayLabel.setTitle(" Monday | Hours : \(monHours)", for: .normal)
        tuesdayLabel.setTitle(" Tuesday | Hours : \(tueHours)", for: .normal)
        wednesdayLabel.setTitle(" Wednesday | Hours : \(wedHours)", for: .normal)
        thursdayLabel.setTitle(" Thursday | Hours : \(thurhours)", for: .normal)
        fridayLabel.setTitle(" Friday | Hours : \(friHours)", for: .normal)
        saturdayLabel.setTitle(" Saturday | Hours : \(satHours)", for: .normal)
               
    }
    
    func saveData() {
        defaults.set(timeSheetExport, forKey: keys.timeSheetExport)
        defaults.set(emailBrain.getUserEmail(), forKey: keys.userEmail)
        defaults.set(sunHours, forKey: keys.sunHours)
        defaults.set(monHours, forKey: keys.monHours)
        defaults.set(tueHours, forKey: keys.tuesHours)
        defaults.set(wedHours, forKey: keys.wedHours)
        defaults.set(thurhours, forKey: keys.thusHours)
        defaults.set(friHours, forKey: keys.friHours)
        defaults.set(satHours, forKey: keys.satHours)
        
    }
    
    func checkForSavedData() {
        let savedTimeSheetExport = defaults.object(forKey: keys.timeSheetExport) as? [String] ?? [String]()
        timeSheetExport = savedTimeSheetExport
        
        let savedUserEmail = defaults.value(forKey: keys.userEmail) as? String ?? "No Email Saved"
        emailBrain.setUserEmail(emailAddress: savedUserEmail)
        
        
        let savedSundayHours = defaults.double(forKey: keys.sunHours)
        sunHours = savedSundayHours
        
        let savedMondayHours = defaults.double(forKey: keys.monHours)
        monHours = savedMondayHours
        
        let savedTuesdayHours = defaults.double(forKey: keys.tuesHours)
        tueHours = savedTuesdayHours
        
        let savedWednesdayHours = defaults.double(forKey: keys.wedHours)
        wedHours = savedWednesdayHours
        
        let savedThursdayHours = defaults.double(forKey: keys.thusHours)
        thurhours = savedThursdayHours
        
        let savedFridayHours = defaults.double(forKey: keys.friHours)
        friHours = savedFridayHours
        
        let savedSaturdayHours = defaults.double(forKey: keys.satHours)
        satHours = savedSaturdayHours
        
        whichDayOfTheWeek()
        setHoursOnDaysVC()
    }
    
    func clearTimeSheetData() {
        /*
         function clears all time sheet data stored in variables
         resets hours on days VC Buttons
         then saves the changes into user defaults
         */
        
        timeSheetExport = []
        //print("week has been cleared - \(timeSheetExport)")
        
        // Sets all day hours to 0.0
        monHours  = 0.0
        tueHours  = 0.0
        wedHours  = 0.0
        thurhours = 0.0
        friHours  = 0.0
        satHours  = 0.0
        sunHours  = 0.0
        
        // Clear csvString or the data will stay after its been cleared
        csvString = ""
        
        /*Call whichDayOfTheWeek() & setHoursOnDaysVC() to reset hours on
          days VC Buttons
        */
        whichDayOfTheWeek()
        setHoursOnDaysVC()
        
        // save data after clearing or if closed app then reopen data will be reloaded
        // from user defaults
        saveData()
    }
    
    func reloadData () {
        
        // Reloads
        addJobToListString()
        whichDayOfTheWeek()
        setHoursOnDaysVC()
        saveData()
    }
}

//MARK: - MFMailComposeViewControllerDelegate

extension DaysViewController: MFMailComposeViewControllerDelegate {
    
    @IBAction func exportButtonPressed(_ sender: UIButton) {
        
        userEmail = emailBrain.getUserEmail()

        csvString = timeSheetExport.joined(separator: ",")
        print("csv string - \(csvString ?? "No CSV String Data")")
            
        let data = csvString!.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let content = data {
            print("NSData: \(content)")
        }
        
        func sendEmail() {
            if MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                print("Users Email is \(userEmail!)")
                mail.mailComposeDelegate = self
                mail.setToRecipients([userEmail!])
                mail.setSubject("Time Sheet")
                mail.setMessageBody("<p>This weeks Time Sheet</p>", isHTML: true)
                
                //Add CSV File to email
                mail.addAttachmentData(data!, mimeType: "text/csv", fileName: "timeSheet.csv")
                
                self.present(mail, animated: true)
                
            } else {
                // show failure alert
                print("Cannot send mail")
            }
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            
            controller.dismiss(animated: true, completion: nil)
        }
        
        sendEmail()
    }
}



