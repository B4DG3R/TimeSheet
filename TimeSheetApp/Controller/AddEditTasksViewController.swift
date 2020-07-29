//
//  addEditTasks.swift
//  TimeSheetApp
//
//  Created by Matthew Hollyhead on 11/05/2020.
//  Copyright © 2020 Matthew Hollyhead. All rights reserved.
//

import UIKit

class AddEditTasksViewController: UIViewController {
    
    var timeSheetBrain = TimeSheetBrain()
    
    var jobDescription: String?
    var hours: Double?
    var yNumber: Int?
    var jobCode: String?
    var pickerData: [(jobCode: String, jobDescription: String)] = [(String, String)]()
    var jobCodeData: [String: String] = [:]
    var dataReload = true
    
    @IBOutlet weak var jobDescriptionTextField: UITextField!
    @IBOutlet weak var hoursTextField: UITextField!
    @IBOutlet weak var yNumberTextField: UITextField!
    @IBOutlet weak var jobCodeTextField: UITextField!
    @IBOutlet weak var jobCodePickerClicked: UIPickerView!
    
    @IBAction func jobDescriptionClicked(_ sender: UITextField) {
        print("Job Description Clicked")
    }
    
    @IBAction func HoursFieldClicked(_ sender: UITextField) {
        hoursTextField.keyboardType = UIKeyboardType.decimalPad
        jobCodePickerClicked.isHidden = true;
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: Notification.Name("jobDescriptionTextField"), object: jobDescriptionTextField.text)
        NotificationCenter.default.post(name: Notification.Name("hoursTextField"), object: hoursTextField.text)
        NotificationCenter.default.post(name: Notification.Name("yNumberTextField"), object: yNumberTextField.text)
        NotificationCenter.default.post(name: Notification.Name("jobCodeTextField"), object: jobCodeTextField.text)
        
        NotificationCenter.default.post(name: Notification.Name("ReloadData"), object: dataReload)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Connect Picker Data
        jobCodePickerClicked.delegate = self
        jobCodePickerClicked.dataSource = self

        // Picker Data
        pickerData = [("WVTA", "Electrical Repair"), ("WVYB", "Chassis Repair"), ("WVTG", "Cutter Head Repair"), ("WVYH", "Engine Repair"), ("WVTN", "Tyre Repair"), ("WVYP", "Transmission Repair"), ("WVTV", "Hydraulic Repair"), ("9N03", "Supervision")]

        self.jobCodePickerClicked.isHidden = true;

        jobCodeTextField.delegate = self
        jobCodeTextField.inputView = jobCodePickerClicked
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension AddEditTasksViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // number of colums of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    //Place UIPicker View data view in return
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row].jobDescription
    }
    
    // fills job code and job description fields with data from pickerData
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        jobCodeTextField.text = pickerData[row].jobCode
        jobDescriptionTextField.text = pickerData[row].jobDescription
        jobCodePickerClicked.isHidden = true;
    }
}

//MARK: - UITextFieldDelegate

extension AddEditTasksViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        jobCodePickerClicked.isHidden = false;
        return false
    }
}
