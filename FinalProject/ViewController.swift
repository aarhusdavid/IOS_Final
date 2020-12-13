//
//  ViewController.swift
//  FinalProject
//
//  Created by David Aarhus on 12/7/20.
//  Copyright © 2020 David Aarhus. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    
    @IBOutlet var tableView: UITableView!
    
    var tasks = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.title = "Tasks"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Setup
        
        if !UserDefaults().bool(forKey: "setup")
        {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
        }
        
        // get all current saved tasks
        updateTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    func updateTasks()
    {
        tasks.removeAll()
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else
        {
            return
        }
        
        for x in 0..<count
        {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String
            {
                tasks.append(task)
            }
        }
        
        tableView.reloadData()
    }
    
    
    @IBAction func didTapAdd()
    {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update =
        {
            DispatchQueue.main.async
            {
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
   

        
    @IBAction func editTask()
    {
        let et = storyboard?.instantiateViewController(identifier: "entry") as! TaskViewController
        et.title = "Edit Task"
//        vc.update =
//        {
//            DispatchQueue.main.async
//            {
//                self.updateTasks()
//            }
//        }
    }

}


extension ViewController: UITableViewDelegate
{
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let selectedtask = tasks[indexPath.row]
           
           if let viewController = storyboard?.instantiateViewController(identifier: "TaskViewController") as? TaskViewController {
               viewController.task = selectedtask
               navigationController?.pushViewController(viewController, animated: true)
           }
       }
}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
    
    
}

