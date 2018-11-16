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
    
    var habits: [Habit] = [
        Habit(title: "Go to bed before 10pm", image: Habit.Images.book),
        Habit(title: "Drink 8 glasses of water", image: Habit.Images.book),
        Habit(title: "Commit today", image: Habit.Images.book),
        Habit(title: "Stand up every hour", image: Habit.Images.book)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        tableView.register(HabitTableViewCell.nib, forCellReuseIdentifier: HabitTableViewCell.identifier)
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
    }

    @objc func pressAddHabit(_ sender: UIBarButtonItem) {
        // creating a new instance of AddHabitViewController
        let addHabitVC = AddHabitViewController.instantiate()
        let navigationController = UINavigationController(rootViewController: addHabitVC)
        present(navigationController, animated: true, completion: nil)
    }
}
