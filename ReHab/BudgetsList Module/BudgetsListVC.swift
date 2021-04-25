//  BudgetsListVC.swift
//  ReHab
import UIKit

class BudgetsListVC: UIViewController, BudgetsListViewInterface, UITableViewDataSource {

    @IBOutlet weak var btnNewBudget: UINavigationItem!
    @IBOutlet weak var table: UITableView!
    private let idCell = String(describing: BudgetCell.self)
    
    private let presenter = BudgetsListPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewInterface = self
        table.register(UINib(nibName: idCell, bundle: nil), forCellReuseIdentifier: idCell)
        table.rowHeight = UITableView.automaticDimension
        table.dataSource = self
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
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfBudgets
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let budget = presenter.budget(at: indexPath.row)
        let cell = table.dequeueReusableCell(withIdentifier: idCell) as! BudgetCell
        cell.config(with: budget)
        return cell 
    }
    

    
}
