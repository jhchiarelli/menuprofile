//
//  MenuProfileTableViewCell.swift
//  menuprofile
//
//  Created by Jorge Henrique Chiarelli on 19/09/22.
//

import UIKit

class MenuProfileTableViewCell: UITableViewCell {
    
    static let identifier: String = "MenuProfileTableViewCell"
    
    let screen: MenuProfileTableViewCellScreen =  MenuProfileTableViewCellScreen()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.screen.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.screen)
        self.configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.screen.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.screen.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.screen.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.screen.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(title: String) {
        self.screen.titleLabel.text = title
    }
    
}
