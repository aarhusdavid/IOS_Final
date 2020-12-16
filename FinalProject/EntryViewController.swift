//
//  EntryViewController.swift
//  FinalProject
//
//  Created by David Aarhus on 12/9/20.
//  Copyright © 2020 David Aarhus. All rights reserved.
//


import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate
{
    
    @IBOutlet var field: UITextField! // text field for title
    @IBOutlet var notes: UITextField! // text field for notes
    @IBOutlet var datewheel: UIDatePicker! // date field for date
    
    public var completion: ((String, String, Date) -> Void)? // sends into to MyTodoList structure
        
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        notes.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask)) // naviagtes the user between viewControllers
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        field.resignFirstResponder() // prevents the keyboard from getting in the way of the textFields
        notes.resignFirstResponder()
        return true
    }
    
    @objc func saveTask() // this function saves the task after the user has entered all the information
    {
        if let title = field.text, !title.isEmpty, // this checks to see if the user left the title field empty
            let note = notes.text, !note.isEmpty // this checks to see if the user left the notes field empty
        {
            let targetDate = datewheel.date
            completion?(title,note,targetDate)
        }
    }
}
