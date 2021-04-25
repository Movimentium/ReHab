//  BudgetsListVC.swift
//  ReHab
import UIKit

class BudgetsListVC: UIViewController, BudgetsListViewInterface, UITableViewDataSource {

    @IBOutlet weak var btnNewBudget: UINavigationItem!
    @IBOutlet weak var table: UITableView!
    private let idCell = String(describing: BudgetCell.self)
    
    private var presenter: BudgetsListPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = BudgetsListPresenter(withViewInterface: self,
                                         dataProv: ModelDataProvider())
        
        table.register(UINib(nibName: idCell, bundle: nil), forCellReuseIdentifier: idCell)
        table.rowHeight = UITableView.automaticDimension
        table.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        table.reloadData()
    }
    
    private func setupUI() {
        title = "budgets".localized()
    }
    
    
    // MARK: - IBActions
    @IBAction func onBtnNewBudget(_ sender: UIBarButtonItem) {
        presenter.onBtnNewBudget()
    }
    
    // MARK: - BudgetsListViewInterface
    func push(newBudgetVC: UIViewController) {
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
