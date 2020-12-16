//
//  ViewController.swift
//  FinalProject
//
//  Created by David Aarhus on 12/7/20.
//  Copyright © 2020 David Aarhus. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate{

    @IBOutlet var tableView: UITableView! //tableview for task
    @IBOutlet weak var sortButton: UIButton! //button to sort titles
    @IBOutlet weak var datesortButton: UIButton! // button to sort tasks by date
    
    var tasks = [MyTodoList]() // creates my task list from my struct
    
    struct MyTodoList // attributes of each tast are defined here.
    {
        let title: String
        let date: Date
        let notes: String
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Tasks" // labels the title of the view Controller
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    // function enables the user to sort the tasks alphabetically
    @IBAction func sortTitles(_ sender: Any) {
        let itemSort = tasks
        self.tasks = itemSort.sorted {$0.title < $1.title}
        tableView.reloadData()
    }
    
    // function enables the user to sort the tasks by date.
    @IBAction func sortDates(_ sender: Any) {
        let dateSort = tasks
        self.tasks = dateSort.sorted {$0.date < $1.date}
        tableView.reloadData()
    }
    
    // this function allows the user to create a new task with a title, notes, and date
    @IBAction func didTapAdd()
    {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        
        vc.title = "New Task" //labels the title of the new viewcontroller
        vc.completion = {title, body, date in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                let new = MyTodoList(title: title, date: date, notes: body) // creates new task
                self.tasks.append(new) //adds the new task to the mytodolist object
                self.tableView.reloadData() //reloads in data to tableView
            }
        }
        navigationController?.pushViewController(vc, animated: true) // // navigates user between viewcontrollers
    }
}

extension ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    // this function helps layout the infomation of each task in each cell of the table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let Title = tasks[indexPath.row].title //grabs the title
        let date = tasks[indexPath.row].date //grabs the date
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM, dd, YYYY, hh:mm a" // formats the date all the way down to AM/PM
        cell.textLabel?.text = "\(Title)" + " - " + " \(formatter.string(from: date))" // cell label consists of title and date
        let details = tasks[indexPath.row].notes //grabs notes
        cell.detailTextLabel?.text = details // cell details consists of notes
        return cell
    }
    
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {return UITableView.automaticDimension;}
    
    // this is the function that enables the user to swipe right on any cell
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       return UISwipeActionsConfiguration(actions: [
           edit(forRowAt: indexPath) // calls edit function
       ])
    }
    
    // this is the function that enables the user to swipe left on any cell
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       return UISwipeActionsConfiguration(actions: [
           delete(forRowAt: indexPath) // calls delete function
       ])
    }

    // this is the function for what happens when a user swipes left on a cell in the table View
    private func delete(forRowAt indexPath: IndexPath) -> UIContextualAction {
       return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
        self.tasks.remove(at: indexPath.row) //removes cell
        self.tableView.reloadData() //reloads the whole table
        print("DELETED") // prints deleted in the feedback window
        completion(true)
       }
    }
    

    // this is the function for what happends when a user swipes right on a cell in the table View
    private func edit(forRowAt indexPath: IndexPath) -> UIContextualAction {
       return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
        
        self.tasks.remove(at: indexPath.row) //removes the cell
        let vc = self.storyboard?.instantiateViewController(identifier: "task") as! TaskViewController
            vc.title = "Edit Task" //labels the title of the entryviewcontroller
            vc.updatedCompletion = {title, body, date in
                DispatchQueue.main.async {
                    self.navigationController?.popToRootViewController(animated: true)
                    let updated = MyTodoList(title: title, date: date, notes: body) // creates updated task
                    self.tasks.insert(updated, at: indexPath.row) //adds the update task to the mytodolist object
                    self.tableView.reloadData() //reloads in data to tableView
                }
            }
        self.navigationController?.pushViewController(vc, animated: true) // navigates user between viewcontrollers
        print("EDITED") // prints EDITED in the feedback window
        completion(true)
       }
    }
    
}
                


 
