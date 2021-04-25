//
//  NewBudgetVC.swift
//  ReHab
//
//  Created by Miguel on 19/04/2021.
//

import UIKit

class NewBudgetVC: UIViewController, NewBudgetViewInterface, UIPickerViewDataSource, UIPickerViewDelegate
{


    
    @IBOutlet weak var vwMsg: UIView!
    @IBOutlet weak var lblMsg: UILabel!

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
    
    @IBOutlet weak var constrFormTop: NSLayoutConstraint!
    @IBOutlet weak var constrVwMsgTop: NSLayoutConstraint!
    @IBOutlet weak var constrVwMsgHeight: NSLayoutConstraint!

    private let btnSave = UIBarButtonItem(title: "save".localized(),
                                          style: .plain,
                                          target: self,
                                          action: #selector(onBtnSave))
    private var pickerSubCategory = UIPickerView()
    private var pickerLocation = UIPickerView()

    private var presenter: NewBudgetPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPickers()
        presenter = NewBudgetPresenter(withViewInterface: self,
                                       dataProv: ModelDataProvider())
    }
    
    private func setupUI() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.rightBarButtonItem = btnSave
        constrVwMsgTop.constant = -constrVwMsgHeight.constant
        
        // Strings
        title = "newBudget".localized()
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
    

    // MARK: - IBActions
    @objc private func onBtnSave() {
    
    }

    

    // MARK: - NewBudgetViewInterface
    func setUserInterationEnabled(_ isEnabled: Bool) {
          view.isUserInteractionEnabled = isEnabled
    }
    
    func didLoadDataForForm() {
        pickerSubCategory.dataSource = self
        pickerSubCategory.delegate = self
        pickerLocation.dataSource = self
        pickerLocation.delegate = self
    }
    
    func showErrorLoadingAndExit() {
         
    }
    
    
    // MARK: - UIPickerView methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == pickerSubCategory {
            return presenter.numberOfCategories
        } else {
            return presenter.numberOfLocations
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pickerSubCategory {
            return presenter.category(at: row)
        } else {
            return presenter.location(at: row)
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pickerSubCategory {
            return presenter.didSelectCategory(at: row)
        } else {
            return presenter.didSelectLocation(at: row)
        }
    }
    
    private func setupPickers() {
        let toolBar = UIToolbar()
        toolBar.isTranslucent = false
        toolBar.backgroundColor = .white
        toolBar.tintColor = .habOrange
        let btnDone = UIBarButtonItem(title: "ok".localized(),
                                      style: .plain,
                                      target: self,
                                      action: #selector(onBtnPickerDone))
        let btnSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                       target: nil, action: nil)
        toolBar.items = [btnSpace, btnDone]
        toolBar.sizeToFit()
        pickerLocation.backgroundColor = .habOrangeLite
        pickerSubCategory.backgroundColor = .habOrangeLite
        txtSubCategory.inputView = pickerSubCategory
        txtSubCategory.inputAccessoryView = toolBar
        txtLocation.inputView = pickerLocation
        txtLocation.inputAccessoryView = toolBar
    }

    @objc private func onBtnPickerDone() {
        if txtSubCategory.isEditing {
            let i = pickerSubCategory.selectedRow(inComponent: 0)
            presenter.didSelectCategory(at: i)
            txtSubCategory.text = presenter.category(at: i)
            txtSubCategory.resignFirstResponder()
        }
        else if txtLocation.isEditing {
            let i = pickerLocation.selectedRow(inComponent: 0)
            presenter.didSelectLocation(at: i)
            txtLocation.text = presenter.location(at: i)
            txtLocation.resignFirstResponder()
        }
    }

    
}
