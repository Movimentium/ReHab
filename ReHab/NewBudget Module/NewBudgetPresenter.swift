//
//  NewBudgetPresenter.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

protocol NewBudgetViewInterface: AnyObject {
    func didLoadDataForForm()
}

class NewBudgetPresenter {
    /*
     private func setupInputViews() {
         
         let toolBar = UIToolbar()
         toolBar.isTranslucent = false
         toolBar.backgroundColor = .white
         toolBar.tintColor = K.Color.navBarTitle
         let btnDone = UIBarButtonItem(title: "done".localized(), style: .done, target: self, action: #selector(onBtnDone))
         let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
         toolBar.items = [btnSpace,btnDone]
         toolBar.sizeToFit()
         
         txtInvisibleBirthMom.inputView = momDatePicker
         txtInvisibleBirthDad.inputView = dadDatePicker
         txtInvisibleBirthMom.inputAccessoryView = toolBar
         txtInvisibleBirthDad.inputAccessoryView = toolBar
     }

     */

    weak var viewInterface: NewBudgetViewInterface?
    
    private var arrCategories: [String] = ["A","B", "C"]
    private var arrLocations: [String] = ["X","Y", "Z"]
    
    private var idxCategorySelected: Int?
    private var idxLocationSelected: Int?
    
    init() {
       // viewInterface?.didLoadDataForForm()
    }
    
    
    // MARK: - Category methods
    var numberOfCategories: Int {
        return arrCategories.count
    }
    
    func category(at i:Int) -> String {
        return arrCategories[i]
    }
    
    func didSelectCategory(at i:Int) {
        
    }
    
    // MARK: - Location methods
    var numberOfLocations: Int {
        return arrLocations.count
    }
    
    func location(at i:Int) -> String {
        return arrLocations[i]
    }
    
    func didSelectLocation(at i:Int) {
        
    }
}
