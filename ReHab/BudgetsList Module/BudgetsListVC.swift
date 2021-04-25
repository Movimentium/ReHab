//  BudgetsListVC.swift
//  ReHab
import UIKit

class BudgetsListVC: UIViewController, BudgetsListViewInterface {

    @IBOutlet weak var btnNewBudget: UINavigationItem!
    @IBOutlet weak var table: UITableView!
    
    
    private let presenter = BudgetsListPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewInterface = self
    }
    
    private func setupUI() {
        title = "budgets".localized()
    }
    
    
    // MARK: - IBActions
    @IBAction func onBtnNewBudget(_ sender: UIBarButtonItem) {
        presenter.onBtnNewBudget()
    }
    
    
    // MARK: - BudgetsListViewInterface
    func goToNewBudgetVC() {
        let sb = UIStoryboard(name: "NewBudget", bundle: nil)
        let newBudgetVC = sb.instantiateInitialViewController()!
        navigationController!.pushViewController(newBudgetVC, animated: true)
    }
    
    
}
