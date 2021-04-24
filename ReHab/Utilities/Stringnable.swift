//
//  Stringnable.swift
//  ReHab
//
//  Created by Miguel on 24/04/2021.
//

import Foundation

protocol Stringnable {
    var str: String { get }
}

extension Stringnable {
    var str: String {
        let mirror = Mirror(reflecting: self)
        let strType = "\(mirror.subjectType)"
        // To provide better visibility and object diferentation
        var s = "> > \(strType):\n"
        for _ in 0...(strType.count + 5) {
            s += "-"
        }
        s += "\n"
        for (k, v) in mirror.children {
            var strValue = ""
            if let s = v as? String {
                strValue = s
            }
            else if let n = v as? Int {
                strValue = n.description
            }
            else if let b = v as? Bool {
                strValue = (b ? "true" : "false" )
            }
            else if let f = v as? Float {
                strValue = f.description
            }
            else if let d = v as? Double {
                strValue = d.description
            }
            else if let arr = v as? [Any?] {
                for obj in arr  {
                    if let o = obj as? Stringnable {
                        strValue += "\n\n"
                        strValue += o.str
                    }
                }
            }
            else {
                strValue = "---"
            }
            s.append("\(k ?? "---"): \(strValue)\n")
        }
        return s
    }
}
