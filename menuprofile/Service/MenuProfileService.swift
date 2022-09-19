//
//  MenuProfileService.swift
//  menuprofile
//
//  Created by Jorge Henrique Chiarelli on 16/09/22.
//

import UIKit
import Alamofire

protocol MenuProfileServiceDelegate: GenericService {
    func getMenuFromJson(completion: @escaping completion<MenuProfileGroup?>)
    func getMenu(completion: @escaping completion<MenuProfileGroup?>)
}

class MenuProfileService: MenuProfileServiceDelegate {
    
    func getMenu(completion: @escaping completion<MenuProfileGroup?>) {
        let url: String = "https://run.mocky.io/v3/d8a8ed8d-d85b-45b7-9444-aef6363012af"
        
        AF.request(url, method: .get).validate().responseDecodable(of: MenuProfileGroup.self) { response in
            print(#function)
            debugPrint(response)
            
            switch response.result {
            case .success(let succecss) :
                print("SUCCESS -> \(#function)")
                completion(succecss, nil)
            
            case .failure(let error) :
                print("ERROR -> \(#function)")
            completion(nil, Error.errorRequest(error))
            }
        }
    }
    
    func getMenuFromJson(completion: @escaping completion<MenuProfileGroup?>) {
        if let url = Bundle.main.url(forResource: "menuProfile", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let menu: MenuProfileGroup = try JSONDecoder().decode(MenuProfileGroup.self, from: data)
                completion(menu, nil)
            } catch {
                completion(nil, Error.fileDecodingFailed(name: "menuProfile", error))
            }
        }
    }
    

}
