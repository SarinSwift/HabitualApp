//
//  HabitTableViewCell.swift
//  Habitual
//
//  Created by Sarin Swift on 11/14/18.
//  Copyright © 2018 sarinswift. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    // set the identifier for the custom cell
    static let identifier = "habit cell"
    
    // returning the nib file after instantiating it
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var imageViewIcon: UIImageView!
    @IBOutlet weak var labelHabitTitle: UILabel!
    @IBOutlet weak var labelStreaks: UILabel!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // sets the content of the UIImageView and UILabels and evaluates if the cell should show a check mark or the right arrow
    func configure(_ habit: Habit) {
        self.imageViewIcon.image = habit.selectedImage.image
        self.labelHabitTitle.text = habit.title
        self.labelStreaks.text = "streaks: \(habit.currentStreak)"
        
        if habit.hasCompletedForToday {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .disclosureIndicator
        }
    }
    
}
