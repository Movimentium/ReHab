//
//  BudgetsListPresenter.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

protocol BudgetsListViewInterface: AnyObject {
    func goToNewBudgetVC()
}

class BudgetsListPresenter {
    
    weak var viewInterface: BudgetsListViewInterface?
    
    var arrBudgets:[Budget] = []
        
    func onBtnNewBudget() {
        viewInterface?.goToNewBudgetVC()
    }
    
    var numberOfBudgets: Int {
        return arrBudgets.count
    }
    
    func budget(at i:Int) -> Budget {
        return arrBudgets[i]
    }
    
}
