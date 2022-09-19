//
//  MenuProfileViewModel.swift
//  menuprofile
//
//  Created by Jorge Henrique Chiarelli on 16/09/22.
//

import UIKit

enum TypeFetch {
    case mock
    case request
}

protocol MenuProfileViewModelDelegate: AnyObject {
    func success()
    func error(_ message: String)
}

class MenuProfileViewModel {
    
    private let service: MenuProfileService = MenuProfileService()
    private weak var delegate: MenuProfileViewModelDelegate?
    
    public func delegate(delegate: MenuProfileViewModelDelegate?) {
        self.delegate = delegate
    }
    
    public func fetch(_ typeFetch: TypeFetch) {
        switch typeFetch {
        case .mock:
            self.service.getMenuFromJson { success, error in
//                print(success)
                if let success = success {
                    self.delegate?.success()
                } else {
                    self.delegate?.error(error?.localizedDescription ?? "")
                }
            }
        case .request:
            self.service.getMenu { success, error in
//                print(success)
                if let success = success {
                    self.delegate?.success()
                } else {
                    self.delegate?.error(error?.localizedDescription ?? "")
                }
            }

        }
    }
}
