//
//  LandingVC.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

class LandingVC: UIViewController, LandingViewInterface {
    
    private let presenter = LandingPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewInterface = self

    }
    
    
    // MARK: - LandingViewInterface
    func goToBudgetsList() {
        
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
 
}
