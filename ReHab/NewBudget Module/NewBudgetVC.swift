//
//  NewBudgetVC.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

class NewBudgetVC: UIViewController, NewBudgetViewInterface {
   
    
    
    private let presenter = NewBudgetPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewInterface = self
 
    }
    
    // MARK: - NewBudgetViewInterface
    func nada() {
         
    }
    

    

}
