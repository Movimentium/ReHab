//
//  NewBudgetPresenter.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

protocol NewBudgetViewInterface: AnyObject {
    func nada()
}

class NewBudgetPresenter {
    weak var viewInterface: NewBudgetViewInterface?
}
