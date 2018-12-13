//
//  Meal.swift
//  FoodTracker
//
//  Created by Jane Appleseed on 11/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit
import os.log


struct Meal: Codable {
    
    //MARK: Properties
    
    var name: String
    var photo: Data?
    var rating: Int
    
    var image: UIImage? {
        if let photo = photo {
            return UIImage(data: photo)
        } else {
            return nil
        }
    }
    
    //MARK: Archiving Paths
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("meals")
    
    
    static func saveMeals(_ meals: [Meal]) {
        
        let propertyEncoder = PropertyListEncoder()
        let mealsData = try? propertyEncoder.encode(meals)
        try? mealsData?.write(to: archiveURL)

    }
    
    static func loadMeals() -> [Meal]?  {
        let propertyDecoder = PropertyListDecoder()
        if let data = try? Data(contentsOf: archiveURL), let meals = try? propertyDecoder.decode([Meal].self, from: data) {
            return meals 
        } else {
            return nil
        }
    }
}
