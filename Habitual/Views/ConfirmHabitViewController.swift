//
//  ConfirmHabitViewController.swift
//  Habitual
//
//  Created by Sarin Swift on 11/15/18.
//  Copyright © 2018 sarinswift. All rights reserved.
//

import UIKit

class ConfirmHabitViewController: UIViewController {
    
    var habitImage: Habit.Images!

    @IBOutlet weak var habitImageView: UIImageView!
    @IBOutlet weak var habitNameInputField: UITextField!
    @IBOutlet weak var createHabitButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateUI()
    }
    
    @IBAction func createHabitButtonPressed(_ sender: UIButton) {
        var persistanceLayer = PersistenceLayer()
        guard let name = habitNameInputField.text else {
            return
        }
        if name == "" {
            popupClicked()
        }
        
        persistanceLayer.createNewHabit(name: name, image: habitImage)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func popupClicked() {
        let ac = UIAlertController(title: "No message", message: "Please enter your habit", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }
    
    func updateUI() {
        title = "New Habit"
        // actually shows the image on the viewcontroller
        habitImageView.image = habitImage.image
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
