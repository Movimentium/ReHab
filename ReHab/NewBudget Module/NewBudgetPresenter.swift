//
//  NewBudgetPresenter.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

protocol NewBudgetViewInterface: AnyObject {
    func didLoadDataForForm()
    func showErrorLoadingAndExit()
    func setUserInterationEnabled(_ isEnabled:Bool)
}

class NewBudgetPresenter {

    private weak var viewInterface: NewBudgetViewInterface?
    private let dataProvider: ModelDataProviderProtocol
    private let catId = "001-2" // Reformas
    
    private var arrCategories: [SubCategory] = []
    private var arrLocations: [Location] = []
    
    private var idxCategorySelected: Int?
    private var idxLocationSelected: Int?
    
    
    init(withViewInterface viewInterface: NewBudgetViewInterface, dataProv: ModelDataProviderProtocol) {
        self.viewInterface = viewInterface
        self.dataProvider = dataProv
        self.viewInterface?.setUserInterationEnabled(false)
        loadSubCategories()
    }
    
    private func loadSubCategories() {
        dataProvider.getSubCategories(forParentId: catId) { [weak self] (arr:[SubCategory]) in
            if arr.isEmpty {
                DispatchQueue.main.async {
                    self?.viewInterface?.showErrorLoadingAndExit()
                }
            } else {
                self?.arrCategories = arr
                self?.loadLocations()
            }
        }
    }
    
    private func loadLocations() {
        dataProvider.getLocations { [weak self] (arr:[Location]) in
            DispatchQueue.main.async {
                if arr.isEmpty {
                    self?.viewInterface?.showErrorLoadingAndExit()
                } else {
                    self?.arrLocations = arr
                    self?.viewInterface?.setUserInterationEnabled(true)
                    self?.viewInterface?.didLoadDataForForm()
                }
            }
        }
    }
    
    
    
    
    // MARK: - Category methods
    var numberOfCategories: Int {
        return arrCategories.count
    }
    
    func category(at i:Int) -> String {
        let subCategory = arrCategories[i]
        return subCategory.name
    }
    
    func didSelectCategory(at i:Int) {
        
    }
    
    // MARK: - Location methods
    var numberOfLocations: Int {
        return arrLocations.count
    }
    
    func location(at i:Int) -> String {
        let loc = arrLocations[i]
        let strLocation: String = "\(loc.zip) - \(loc.name)"
        return strLocation
    }
    
    func didSelectLocation(at i:Int) {
        
    }
}
