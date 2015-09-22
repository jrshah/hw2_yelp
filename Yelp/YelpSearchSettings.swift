//
//  YelpSearchSettings.swift
//  Yelp
//
//  Created by Jay Shah on 9/19/15.
//  Copyright © 2015 Timothy Lee. All rights reserved.
//

import Foundation

class YelpSearchSettings {
    
    var searchString: String?
    var categories: [String]?
    var deals: Bool?
    var sortBy: Int?
    var distance: Int?
    var limit: Int?
    var offset: Int?
    
    init() {
        self.searchString  = "Restaurants"
        self.categories = ["asianfusion", "burgers"]
        self.deals = false
        self.sortBy = 0
        self.distance = 1000
        
        self.limit = 20
        self.offset = 1
        
    }
    
}