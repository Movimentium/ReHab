//
//  LandingPresenter.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

protocol LandingViewInterface: AnyObject {
    func goToBudgetsList()
}

class LandingPresenter {
    weak var viewInterface: LandingViewInterface?
}
