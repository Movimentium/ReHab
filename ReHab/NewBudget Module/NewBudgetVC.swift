//
//  NewBudgetVC.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

class NewBudgetVC: UIViewController, NewBudgetViewInterface {
   
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var lblSubCategory: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtSubCategory: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtVwDescrip: UITextView!
    
    private let presenter = NewBudgetPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewInterface = self
        setupUI()
    }
    
    private func setupUI() {
        lblName.text = "name".localized()
        lblEmail.text = "email".localized()
        lblPhone.text = "phone".localized()
        lblSubCategory.text = "subCategory".localized()
        lblLocation.text = "location".localized()
        lblDescription.text = "descrip".localized()
    }
    
    /*
     
     @objc private func keyboardWillChangeFrame(_ notif:Notification) {
         guard let info = notif.userInfo,
               let fr:CGRect = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
               let animTime = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
         else {
             return
         }
         let pntOrigin = txtBabyName.frame.origin
         print("txtBabyName.frame.origin: \(pntOrigin)")
         let pnt0inView = contentVw.convert(pntOrigin, to: view)
         print("in view \(pnt0inView)")
         if fr.origin.y >= view.bounds.height {
             constrTopFirstLbl.constant = valConstrTopFirstLbl
         } else if txtBabyName.isEditing {
             constrTopFirstLbl.constant -= (fr.height - (K.h - pnt0inView.y) + txtBabyName.bounds.height + 4)
         }
         UIView.animate(withDuration: animTime, delay: 0,
                        options: [], animations: {
                         self.view.layoutIfNeeded()
                        }, completion: nil)
     }
     */
    
    
    // MARK: - NewBudgetViewInterface
    func nada() {
         
    }
    

    

}
