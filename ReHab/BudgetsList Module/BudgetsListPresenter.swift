//
//  BudgetsListPresenter.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

protocol BudgetsListViewInterface: AnyObject {
    func nada()
}

class BudgetsListPresenter {
    weak var viewInterface: BudgetsListViewInterface?
}
