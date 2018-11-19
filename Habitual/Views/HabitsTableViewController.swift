//
//  MainViewController.swift
//  Habitual
//
//  Created by Sarin Swift on 11/13/18.
//  Copyright © 2018 sarinswift. All rights reserved.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    
    private var persistance = PersistenceLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        tableView.register(HabitTableViewCell.nib, forCellReuseIdentifier: HabitTableViewCell.identifier)
        
        let longPressRecongnizer = UILongPressGestureRecognizer(target: self, action: #selector(HabitsTableViewController.longPress(longPressGestureRecognizer:)))
        self.view.addGestureRecognizer(longPressRecongnizer)
    }
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                // same functionality as the 'commit editingStyle'
                let habitToDelete = persistance.habits[indexPath.row]
                let habitIndexToDelete = indexPath.row
                let deleteAlert = UIAlertController(habitTitle: habitToDelete.title) {
                    self.persistance.delete(habitIndexToDelete)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                self.present(deleteAlert, animated: true)
            }
        }
    }
    
    // whenever we load this view controller, we want to load the habits
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        persistance.setNeedsToReloadHabits()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persistance.habits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as! HabitTableViewCell
        let habit = persistance.habits[indexPath.row]
        cell.configure(habit)
        
        return cell
    }
    

}

extension HabitsTableViewController {
    
    func setupNavBar() {
        title = "Habitual"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit(_:)))
        navigationItem.rightBarButtonItem = addButton
        navigationItem.leftBarButtonItem = self.editButtonItem
    }

    @objc func pressAddHabit(_ sender: UIBarButtonItem) {
        // creating a new instance of AddHabitViewController
        let addHabitVC = AddHabitViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: addHabitVC)
        present(navigationController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            let habitToDelete = persistance.habits[indexPath.row]
            let habitIndexToDelete = indexPath.row
            
            // deletes the habit from persistance layer and the cell at the indexPath
            let deleteAlert = UIAlertController(habitTitle: habitToDelete.title) {
                self.persistance.delete(habitIndexToDelete)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            self.present(deleteAlert, animated: true)
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        persistance.swapHabits(habitIndex: sourceIndexPath.row, destinationIndex: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(persistance.habits[indexPath.row].title)
        
        let habitDetailedVC = HabitDetailedViewController.instantiate()
        habitDetailedVC.view.layoutIfNeeded()
        habitDetailedVC.habit = persistance.habits[indexPath.row]
        habitDetailedVC.habitIndex = indexPath.row
        habitDetailedVC.labelBestStreak.text = "hello"
        
        navigationController?.pushViewController(habitDetailedVC, animated: true)
        
    }
}

// creating a custom init method for UIAlertController
extension UIAlertController {
    convenience init(habitTitle: String, confirmHandler: @escaping () -> Void) {
        self.init(title: "Delete habit", message: "Are you sure you want to delete \(habitTitle)?", preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { _ in
            confirmHandler()
        }
        self.addAction(confirmAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        self.addAction(cancelAction)
    }
}
