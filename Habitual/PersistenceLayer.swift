//
//  PersistenceLayer.swift
//  Habitual
//
//  Created by Sarin Swift on 11/14/18.
//  Copyright © 2018 sarinswift. All rights reserved.
//

import UIKit

struct PersistenceLayer {
    
    // MARK: - VARS
    
    // making a setter variable so we can write to our array of habits
    // using private becasue we want our array of habits to only be accessible through the PersistenceLayer
    private(set) var habits: [Habit] = []
    
    // this constant is created as a key in UserDefaults to store the array of habits
    // is a constant static becasue we only want one instance of the key no matter how many times this persistence layer is instantiated
    private static let userDefaultsHabitsKeyValue = "HABITS_ARRAY"
    
    init() {
        self.loadHabits()
    }
    
    // make this function mutating becasue we want to alter the copy of data that is assigned when a user instantiates this persistance layer
    private mutating func loadHabits() {
        // instantiate our user defaults
        let userDefaults = UserDefaults.standard
        
        // grab the array of habits from userDefualts for the given key we made earlier
        // decode the JSON data into a swift Habit Object
        guard
            let habitData = userDefaults.data(forKey: PersistenceLayer.userDefaultsHabitsKeyValue),
            let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else {
                return
        }
        // populate our array of habits with our new Habit object
        self.habits = habits
    }
    
    // decorator function: we're not going to be using the results of this function directly
    @discardableResult
    // creates a new habit with the attributes the user passes in
    mutating func createNewHabit(name: String, image: Habit.Images) -> Habit {
        let newHabit = Habit(title: name, image: image)
        // prepending the habits to the array
        self.habits.insert(newHabit, at: 0)
        self.saveHabits()
        
        return newHabit
    }
    
    private func saveHabits() {
        // handling our decoding logic in a guard statement to check if we can decode our aray of habits
        guard let habitsData = try? JSONEncoder().encode(self.habits) else {
            fatalError("could not encode list of habits")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitsData, forKey: PersistenceLayer.userDefaultsHabitsKeyValue)
    }
    
    mutating func delete(_ habitIndex: Int) {
        // remove habit at the given index
        self.habits.remove(at: habitIndex)
        
        // persist the changes we made to our habits array
        self.saveHabits()
    }
    
    
    // Mark Habit Complete
    
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit {
        // variable that stores the product at the given index
        var updatedHabit = self.habits[habitIndex]
        
        // if the habit has been completed, return out of the function with the same habit
        guard updatedHabit.hasCompletedForToday == false else {
            return updatedHabit
        }
        
        updatedHabit.numberOfCompletions += 1
        
        // with our last completion date, we check that the day was yesterday
        // and if it was yesterday, we update the currentStreak by 1
        // if wasn't completed yesterday, we set the current streak to 1
        if let lastCompletionDate = updatedHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            updatedHabit.currentStreak += 1
        } else {
            updatedHabit.currentStreak = 1
        }
        
        if updatedHabit.currentStreak > updatedHabit.bestStreak {
            updatedHabit.bestStreak = updatedHabit.currentStreak
        }
        
        // updating the completion date
        let now = Date()
        updatedHabit.lastCompletionDate = now
        
        // change the chosen habit to reflect the updated habit
        self.habits[habitIndex] = updatedHabit
        self.saveHabits()
        
        return updatedHabit
    }
    
    mutating func swapHabits(habitIndex: Int, destinationIndex: Int) {
        // we remove the current habit from its position and insert it at the destination index
        // lastly, save the newly made changes to our habit array
        let habitToSwap = self.habits[habitIndex]
        self.habits.remove(at: habitIndex)
        self.habits.insert(habitToSwap, at: destinationIndex)
        self.saveHabits()
    }
    
    mutating func setNeedsToReloadHabits() {
        self.loadHabits()
    }
}
