//
//  MenuProfile.swift
//  menuprofile
//
//  Created by Jorge Henrique Chiarelli on 16/09/22.
//

import Foundation

// MARK: - MenuProfileGroup
struct MenuProfileGroup: Codable {
    var group: [MenuProfile]?
}

// MARK: - Group
struct MenuProfile: Codable {
    var title: String?
    var child: [Item]?
}

// MARK: - Child
struct Item: Codable {
    var title: String?
}
