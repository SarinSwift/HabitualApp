//
//  UIViewControllerExtensions.swift
//  Habitual
//
//  Created by Sarin Swift on 11/13/18.
//  Copyright © 2018 sarinswift. All rights reserved.
//

import UIKit

extension UIViewController {
    // static func is associated with the class and not an instance of the class
    static func instantiate() -> Self {
        // returning an instance of the class calling the method and loading a nib file that has the same name as the class calling the method
        // since the .swift and .xib file are named the same, we can use String(describing: self) to get the same name and supply it to the nibName
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}
