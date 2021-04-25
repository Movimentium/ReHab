//
//  ModelDataProvider.swift
//  ReHab
//
//  Created by Miguel on 25/04/2021.
//

import Foundation

class ModelDataProvider: ModelDataProviderProtocol {
    
    private let apiDataProv = APIDataProvider()
    private var appDocsDirURL:URL = FileManager.default.urls(for: .documentDirectory,
                                                              in: .userDomainMask).first!
    private lazy var storeFileURL = appDocsDirURL.appendingPathComponent("Budgets.plist")
    private var arrBudgets:[Budget] = []
    
    init() {
        loadBudgets()
    }
    
    private func loadBudgets() {
        do {
            let data = try Data(contentsOf: storeFileURL)
            arrBudgets = try JSONDecoder().decode([Budget].self, from: data)
        } catch  {
            print("\(Self.self) \(#function)")
            print(error.localizedDescription)
        }
    }

    // MARK: - ModelDataProviderProtocol
    func save(budget: Budget) {
        arrBudgets.append(budget)
        do {
            let data = try JSONEncoder().encode(arrBudgets)
            try data.write(to: storeFileURL)
        } catch {
            print("\(Self.self) \(#function)")
            print(error.localizedDescription)
        }
    }
    
    func budget(at i: Int) -> Budget {
        return arrBudgets[i]
    }
    
    var numberOfBudgets: Int {
        return arrBudgets.count
    }
    
    func getSubCategories(forParentId id: String, completion: @escaping ([SubCategory]) -> Void) {
        apiDataProv.getData(forEndPoint: .subCategoryList(idCat: id)) { (theData:Data?, error:Error?) in
            guard let data = theData else {
                completion([])
                return
            }
            let arr = try? JSONDecoder().decode([CategoryApiResp].self, from: data)
            var arrSubCats:[SubCategory] = []
            for item in arr ?? [] {
                let subCat = SubCategory(id: item.id, name: item.name)
                arrSubCats.append(subCat)
            }
            completion(arrSubCats)
        }
    }
    
    func getLocations(completion: @escaping ([Location]) -> Void) {
        apiDataProv.getData(forEndPoint: .locationList) { (theData:Data?, error:Error?) in
            guard let data = theData else {
                completion([])
                return
            }
            var arr:[LocationApiResp] = []
            do {
                arr = try JSONDecoder().decode([LocationApiResp].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            var arrLocations:[Location] = []
            for item in arr {
                let loc = Location(id: item.id, name: item.name, zip: item.zip)
                arrLocations.append(loc)
            }
            completion(arrLocations)
        }
    }
}
