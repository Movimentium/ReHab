//
//  StringValidator.swift
//  ReHab
//
//  Created by Miguel on 25/04/2021.
//

import UIKit
//
//enum StringValidatorError: Error {
//    case empty
//    case phoneNumber
//    case email
//}

class StringValidator: NSObject {
    
    func isPhoneNumber(_ strNum: String) -> Bool {
        let regEx = "(6|7)[0-9]{8,8}"
        return isValid(regEx, string: strNum)
    }
 
    func isEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return isValid(emailRegEx, string: email)
    }
    
    func isValid(_ str: String?) -> Bool {
        if let s = str, s.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            return true
        }  
        return false
    }
    
    private func isValid(_ regEx: String, string: String) -> Bool {
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: string)
    }
    
}
