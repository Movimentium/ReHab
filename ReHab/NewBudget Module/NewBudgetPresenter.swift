//
//  NewBudgetPresenter.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

protocol NewBudgetViewInterface: AnyObject {
    func didLoadDataForForm()
    func showMessageAndExit(_ msg:String)
    func showMessage(_ msg:String)
    func setUserInterationEnabled(_ isEnabled:Bool)
    func exit()
}

class NewBudgetPresenter {

    private weak var viewInterface: NewBudgetViewInterface?
    private let dataProvider: ModelDataProviderProtocol
    private let validator = StringValidator()
    private let catId = "001-2" // Reformas
    
    private var arrCategories: [SubCategory] = []
    private var arrLocations: [Location] = []
    private var subCategorySelected: SubCategory?
    private var locationSelected: Location?
   

    init(withViewInterface viewInterface: NewBudgetViewInterface,
         dataProv: ModelDataProviderProtocol)
    {
        self.viewInterface = viewInterface
        self.dataProvider = dataProv
    }
    
    func loadSubCategories() {
        dataProvider.getSubCategories(forParentId: catId) { [weak self] (arr:[SubCategory]) in
            if arr.isEmpty {
                DispatchQueue.main.async {
                    self?.viewInterface?.showMessageAndExit("anErrorOcurred".localized())
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
                    self?.viewInterface?.showMessageAndExit("anErrorOcurred".localized())
                } else {
                    self?.arrLocations = arr
                    self?.viewInterface?.setUserInterationEnabled(true)
                    self?.viewInterface?.didLoadDataForForm()
                }
            }
        }
    }
    
    
    func isValid(_ str:String?, isEmail:Bool = false, isPhone:Bool = false) -> Bool {
        if validator.isValid(str) == false {
            viewInterface?.showMessage("isEmptyMsg".localized())
            return false
        }
        // str != nil && str.isEmpty == false
        if isEmail == true {
            if validator.isEmail(str!) == false {
                viewInterface?.showMessage("emailNotValid".localized())
                return false
            }
        } else if isPhone {
            if validator.isPhoneNumber(str!) == false {
                viewInterface?.showMessage("phoneNotValid".localized())
                return false
            }
        }
        return true
    }
    
    func save(_ tuple:BudgetTuple) {
        let newBudget = Budget(subCat: subCategorySelected!,
                               location: locationSelected!)
        newBudget.name = tuple.name
        newBudget.email = tuple.email
        newBudget.phoneNumber = tuple.phone
        newBudget.descrip = tuple.descr
        if dataProvider.save(budget: newBudget) == true {
            viewInterface?.showMessageAndExit("saved".localized())
        } else {
            viewInterface?.showMessageAndExit("anErrorOcurred".localized())
        }

    }

    // MARK: - Category methods
    var numberOfCategories: Int {
        return arrCategories.count
    }
    
    func category(at i:Int) -> String {
        let subCategory = arrCategories[i]
        return subCategory.descrip
    }
    
    func didSelectCategory(at i:Int) {
        subCategorySelected = arrCategories[i]
    }
    
    // MARK: - Location methods
    var numberOfLocations: Int {
        return arrLocations.count
    }
    
    func location(at i:Int) -> String {
        let loc = arrLocations[i]
        return loc.descrip
    }
    
    func didSelectLocation(at i:Int) {
        locationSelected = arrLocations[i]
    }
}
