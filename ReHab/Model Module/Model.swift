//
//  Model.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import Foundation

typealias VoidClosure = ()->Void

class LocationApiResp: Codable {
    var id: Int
    var parent_id: Int
    var name: String
    var normalized_district: String?
    var normalized_city: String?
    var normalized_state: String?
    var zip: String
    var geo_lat: Double
    var level: Int
    var geo_lng: Double
    var children: String?
    var slug: String
}

class CategoryApiResp: Codable {
    var id: String
    var parent_id: String?
    var name: String
    var normalized_name: String?
    var description: String?
    var child_count: Int?
    var children: String?
    var icon: String?
}

typealias BudgetTuple = (name:String, email:String, phone:String, descr:String)

class Budget: Codable, Stringnable {
    var descrip: String = ""
    var subCategory: SubCategory
    var name: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var location: Location
    
    init(subCat:SubCategory, location: Location) {
        self.subCategory = subCat
        self.location = location
    }
}

class SubCategory: Codable, Stringnable, Descriptable {
    var id: String
    var name: String
    
    init(id:String, name:String) {
        self.id = id
        self.name = name
    }
    
    var descrip: String {
        return name
    }
}

class Location: Codable, Stringnable, Descriptable {
    var id: Int
    var name: String
    var zip: String
    
    init(id:Int, name:String, zip:String) {
        self.id = id
        self.name = name
        self.zip = zip
    }
    
    var descrip: String {
        return "\(zip) - \(name)"
    }

}
