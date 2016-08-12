//
//  Topping.swift
//  PizzaThesis
//
//  Created by Hao Lu on 8/4/16.
//  Copyright © 2016 Hao Lu. All rights reserved.
//

import UIKit

class Topping {
    // Mark: Properties
    var name: String
    var image: UIImage?
    var amount: Int
    
    // MARK: Initialization
    init?(name: String, image: UIImage?, amount: Int) {
        // Initialize stored properties.
        self.name = name
        self.image = image
        self.amount = amount
        
        // Initialization should fail if there is no name or if the rating is negative
        if name.isEmpty {
            return nil
        }
    }

    
}