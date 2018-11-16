//
//  Habit.swift
//  Habitual
//
//  Created by Sarin Swift on 11/14/18.
//  Copyright © 2018 sarinswift. All rights reserved.
//

import UIKit

struct Habit: Codable {
    // CaseIterable gives us a class property that returns all the cases in the enum
    enum Images: Int,Codable, CaseIterable {
        // represents each image we added in the Assets file
        case book
        case bulb
        case clock
        case code
        case drop
        case food
        case grow
        case gym
        case heart
        case lotus
        case other
        case pet
        case pill
        case search
        case sleep
        case tooth
        
        // for each case, we get the image by using var image
        var image: UIImage {
            guard let image = UIImage(named: String(describing: self)) else {
                fatalError("image \(self) not found")
            }
            return image
        }
    }
    
    
    var title: String
    let dateCreated: Date = Date()
    var selectedImage: Habit.Images
    
    var currentStreak: Int = 0
    var bestStreak: Int = 0
    var lastCompletionDate: Date?
    var numberOfCompletions: Int = 0
    
    var hasCompletedForToday: Bool {
        return lastCompletionDate?.isToday ?? false
    }
    
    init(title: String, image: Habit.Images) {
        self.title = title
        self.selectedImage = image
    }
    
    
}

extension Date {
    var stringValue: String {
        return DateFormatter.localizedString(from: self, dateStyle: .medium, timeStyle: .none)
    }
    var isToday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
    var isYesterday: Bool {
        let calendar = Calendar.current
        return calendar.isDateInYesterday(self)
    }
}
