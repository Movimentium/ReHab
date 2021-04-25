//
//  BudgetCell.swift
//  ReHab
//
//  Created by Miguel on 25/04/2021.
//

import UIKit

class BudgetCell: UITableViewCell {

    @IBOutlet weak var lblSubCat: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDescrip: UILabel!

    func config(with budget:Budget) {
        lblSubCat.text = budget.subCategory.descrip
        lblName.text = budget.name
        lblPhone.text = budget.phoneNumber
        lblEmail.text = budget.email
        lblLocation.text = budget.location.descrip
        lblDescrip.text = budget.descrip
    }
}
