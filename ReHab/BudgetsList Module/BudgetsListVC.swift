//  BudgetsListVC.swift
//  ReHab
import UIKit

class BudgetsListVC: UIViewController, BudgetsListViewInterface {

    
    
    private let presenter = BudgetsListPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewInterface = self
    
    }
    
    // MARK: - BudgetsListViewInterface
    func nada() {
         
    }
}
