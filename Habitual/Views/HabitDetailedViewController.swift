//
//  HabitDetailedViewController.swift
//  Habitual
//
//  Created by Sarin Swift on 11/16/18.
//  Copyright © 2018 sarinswift. All rights reserved.
//

import UIKit

class HabitDetailedViewController: UIViewController {
    
    // MARK: - VARS
    var habit: Habit!
    var habitIndex: Int!
    private var persistance = PersistenceLayer()

    // MARK: - IBACTIONS and IBOUTLETS
    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelCurrentStreaks: UILabel!
    @IBOutlet weak var labelTotalCompletions: UILabel!
    @IBOutlet weak var labelBestStreak: UILabel!
    @IBOutlet weak var labelStartingDate: UILabel!
    @IBOutlet weak var labelLastCompletionDate: UILabel!
    @IBOutlet weak var buttonAction: UIButton!
    
    @IBAction func pressActionButton(_ sender: UIButton) {
        // when a user presses the complete button, we mark the habit as completed in PersistenceLayer
        habit = persistance.markHabitAsCompleted(habitIndex)
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    // MARK: - LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }


    func updateUI() {
        
//      changing the text values to match the habits current updated value
        title = habit.title
        imageViewIcon.image = habit.selectedImage.image
        labelCurrentStreaks.text = "\(habit.currentStreak) days"
        labelTotalCompletions.text = String(habit.numberOfCompletions)
        labelBestStreak.text = String(habit.bestStreak)
        labelStartingDate.text = habit.dateCreated.stringValue
        labelLastCompletionDate.text = habit.lastCompletionDate?.stringValue
        
        if habit.hasCompletedForToday {
            buttonAction.setTitle("Completed for Today!", for: .normal)
        } else {
            buttonAction.setTitle("Mark as completed", for: .normal)
        }
    }
    
    func setupNavBar() {
        title = "Description"
    }

}
