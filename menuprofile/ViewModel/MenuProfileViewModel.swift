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

enum TypeHiddenSection {
    case remove
    case insert
}

class MenuProfileViewModel {
    
    private let service: MenuProfileService = MenuProfileService()
    private weak var delegate: MenuProfileViewModelDelegate?
    private var data: [MenuProfile] = []
    private var hiddenSection = Set<Int>()
    
    public func delegate(delegate: MenuProfileViewModelDelegate?) {
        self.delegate = delegate
    }
    
    public func fetch(_ typeFetch: TypeFetch) {
        switch typeFetch {
        case .mock:
            self.service.getMenuFromJson { success, error in
//                print(success)
                if let success = success {
                    self.data = success.group ?? []
                    self.hiddenAllSection()
                    self.delegate?.success()
                } else {
                    self.delegate?.error(error?.localizedDescription ?? "")
                }
            }
        case .request:
            self.service.getMenu { success, error in
//                print(success)
                if let success = success {
                    self.data = success.group ?? []
                    self.hiddenAllSection()
                    self.delegate?.success()
                } else {
                    self.delegate?.error(error?.localizedDescription ?? "")
                    
                }
            }

        }
    }
    
    public var numberOfSection: Int {
        return self.data.count
    }
    
    public func titleForSection(section: Int) -> String {
        return self.data[section].title ?? ""
    }
    
    public func containsSection(_ section: Int) -> Bool {
        return self.hiddenSection.contains(section)
    }
    
    public func tappedSection(type: TypeHiddenSection, section: Int) {
        if type == .insert {
            self.hiddenSection.insert(section)
        } else {
            self.hiddenSection.remove(section)
        }
    }
    
    public func indexPathForSection(_ section: Int) -> [IndexPath] {
        var indexPath = [IndexPath]()
        let size = self.childCount(section: section)
        
        for row in 0..<size {
            indexPath.append(IndexPath(row: row, section: section))
        }
        return indexPath
    }
    
    private func childCount(section: Int) -> Int {
        return self.data[section].child?.count ?? 0
    }
    
    public func numberOfRowsInSection(section: Int) -> Int {
        if self.containsSection(section) {
            return 0
        } else {
            return self.childCount(section: section)
        }
    }
    
    private func hiddenAllSection() {
        let size = self.numberOfSection
        for index in 0..<size {
            self.hiddenSection.insert(index)
        }
    }
}
