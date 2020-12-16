//
//  TaskViewController.swift
//  FinalProject
//
//  Created by David Aarhus on 12/9/20.
//  Copyright © 2020 David Aarhus. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate {

    
    @IBOutlet var newfield: UITextField!
    @IBOutlet var newnotes: UITextField!
    @IBOutlet var newdatewheel: UIDatePicker!
    
    public var updatedCompletion: ((String, String, Date) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newfield.delegate = self
        newnotes.delegate = self
        
        self.title = "Edit Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .done, target: self, action: #selector(updateTask)) // naviagtes the user between viewControllers
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
       {
           newfield.resignFirstResponder() // prevents the keyboard from getting in the way of the textFields
           newnotes.resignFirstResponder()
           return true
       }
    
    @objc func updateTask() // this function saves the task after the user has entered all the information
       {
           if let title = newfield.text, !title.isEmpty, // this checks to see if the user left the title field empty
               let note = newnotes.text, !note.isEmpty // this checks to see if the user left the notes field empty
           {
               let targetDate = newdatewheel.date
               updatedCompletion?(title,note,targetDate)
           }
       }
    


}
