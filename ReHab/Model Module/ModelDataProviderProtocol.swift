//
//  ModelDataProviderProtocol.swift
//  ReHab
//
//  Created by Miguel on 25/04/2021.
//

import Foundation

protocol ModelDataProviderProtocol {
    
    func getSubCategories(forParentId id:String,
                          completion: @escaping (_ arr:[SubCategory]) -> Void)
    
    func getLocations(completion: @escaping (_ arr:[Location]) -> Void)
    
    func save(budget: Budget) -> Bool
    func budget(at i:Int) -> Budget
     var numberOfBudgets: Int { get }
}
