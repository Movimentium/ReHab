//
//  BudgetsListPresenter.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

protocol BudgetsListViewInterface: AnyObject {
    func push(newBudgetVC:UIViewController)
}

class BudgetsListPresenter {
    
    private weak var viewInterface: BudgetsListViewInterface?
    private let dataProvider: ModelDataProviderProtocol
        
    init(withViewInterface viewInterface: BudgetsListViewInterface,
         dataProv: ModelDataProviderProtocol)
    {
        self.viewInterface = viewInterface
        self.dataProvider = dataProv
    }
    
    func onBtnNewBudget() {
        let sb = UIStoryboard(name: "NewBudget", bundle: nil)
        let newBudgetVC = sb.instantiateInitialViewController() as! NewBudgetVC
        newBudgetVC.presenter = NewBudgetPresenter(withViewInterface: newBudgetVC,
                                                   dataProv: self.dataProvider)
        viewInterface?.push(newBudgetVC: newBudgetVC)
    }
    
    var numberOfBudgets: Int {
        return dataProvider.numberOfBudgets
    }
    
    func budget(at i:Int) -> Budget {
        return dataProvider.budget(at: i)
    }
    
}
