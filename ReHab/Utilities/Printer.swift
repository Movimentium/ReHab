//
//  Printer.swift
//  ReHab
//
//  Created by Miguel on 24/04/2021.
//

import Foundation

protocol Printing {
    func printObject(_ obj:Any?)
    func printRequest(_ request: URLRequest)
    func printResponse(data: Data?, response: HTTPURLResponse?, error: Error?)
}


class Printer: Printing {
    
    private let strNil = "(-nil-)"

    func printObject(_ obj:Any?) {
        if let o = obj as? Stringnable {
            print(o.str)
        } else {
            print("Printer ERROR: object NOT Stringnable ")
        }
    }
    
    func printRequest(_ request: URLRequest) {
        
        let urlString = request.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod!)": ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"
        
        var s = "\n>>-------- REQUEST --------->>\n"
        s += "\(urlString)"
        s += "\n\n"
        s += "\(method) \(path)?\(query) HTTP/1.1\n"
        s += "Host: \(host)\n"
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            s += "\(key): \(value)\n"
        }
        if let body = request.httpBody {
            s += self.dataToPrettyStrJson(data: body)
        }
        s += "\n>>-------------------------->>\n";
        print(s)
    }
    
    func printResponse(data: Data?, response: HTTPURLResponse?, error: Error?){
        
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        
        var s = "\n<<--------- RESPONSE --------<<\n"
        if let urlString = urlString {
            s += "\(urlString)"
            s += "\n\n"
        }
        
        if let statusCode =  response?.statusCode{
            s += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host{
            s += "Host: \(host)\n"
        }
        for (key,value) in response?.allHeaderFields ?? [:] {
            s += "\(key): \(value)\n"
        }
        if let body = data{
            s += self.dataToPrettyStrJson(data: body)
        }
        if error != nil{
            s += "\nError: \(error!.localizedDescription)\n"
        }
        s += "\n<<---------------------------<<\n";
        print(s)
        
    }
    
    private func dataToPrettyStrJson(data: Data) -> String {
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: [.allowFragments])
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObj, options: .prettyPrinted)
            if let string = String(data: jsonData, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        return ""
    }

}
