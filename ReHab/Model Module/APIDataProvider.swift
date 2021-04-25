//
//  APIDataProvider.swift
//  ReHab
//
//  Created by Miguel on 24/04/2021.
//

import Foundation

enum ApiError: Error {
    case unknowed
    case dataResponseNil
    
    var localizedDescription: String {
        var s = "ApiError: "
        switch self {
        case .unknowed:  s += "unknowed"
        case .dataResponseNil:  s += "data response == nil"
        }
        return s
    }
    
}

class APIDataProvider {
    
    private let session: URLSession = .shared
    private let strBaseURL = "https://api.habitissimo.es/"
    var printer: Printing?
    
    fileprivate enum HTTPMethod: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "DELETE"
    }
    
    enum EndPoint {
        case categoryList
        case subCategoryList(idCat:String)
        case locationList
        
        
        fileprivate var strEndPoint: String {
            switch self {
            case .categoryList:  return "category/list/"
            case .subCategoryList(idCat: let idCat):  return "category/list/\(idCat)"
            case .locationList:  return "location/list"
            }
        }
        
        fileprivate var httpMethod: HTTPMethod {
            return .get
        }
        
    }


    private func newRequest(with endPoint: EndPoint) -> URLRequest {
        let url = URL(string: strBaseURL + endPoint.strEndPoint)!
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.httpMethod.rawValue
        
        return request
    }
    
    
    func getData(forEndPoint endPoint: EndPoint, completion: @escaping (_ data:Data?,_ error:Error?) -> Void) {
        let request = newRequest(with: endPoint)
        let task = session.dataTask(with: request) { [weak self] (dataResp:Data?, urlResp:URLResponse?, error:Error?) in
            guard let data = dataResp else {
                completion(nil, ApiError.dataResponseNil)
                return
            }
            guard let httpUrlResp = urlResp as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            self?.printer?.printResponse(data: data, response: httpUrlResp, error: error)
            if httpUrlResp.statusCode == 200 {
                completion(data, nil)
            } else {
                // TODO: define errors
                completion(nil, error)
            }
         }
        task.resume()
    }
    
    
}
