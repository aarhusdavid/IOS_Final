//
//  EntryViewController.swift
//  FinalProject
//
//  Created by David Aarhus on 12/9/20.
//  Copyright © 2020 David Aarhus. All rights reserved.
//

// https://stackoverflow.com/questions/41674497/get-date-from-date-picker-to-string-in-a-variable

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var field: UITextField!
    @IBOutlet var date: UIDatePicker!
       
    var update: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        saveTask()
        return true
    }
    
    @IBAction func saveTask()
    {
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
//        if date.SelectedDate == nil
//        {
//            return
//        }
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else
        {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")

        update?()
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerChanged(sender: UIDatePicker) {

        print("print \(sender.date)")

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let somedateString = dateFormatter.string(from: sender.date)

        print(somedateString)  // "somedateString" is your string date
    }
    
}
