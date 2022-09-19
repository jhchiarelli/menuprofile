//
//  MenuProfileScreen.swift
//  menuprofile
//
//  Created by Jorge Henrique Chiarelli on 16/09/22.
//

import UIKit

class MenuProfileScreen: UIView {
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .purple
        return view
    }()
    
    lazy var upArrowButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(self.tappedBack(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Menu"
        return label
    }()
    
    @objc func tappedBack(_ sender: UIButton) {
        print(#function)
    }
    
    lazy var tabbleView: UITableView = {
        let tv = UITableView(frame: CGRect(), style: .grouped)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .white
        tv.separatorStyle = .none
        // TODO Register
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .purple
        self.headerView.addSubview(self.upArrowButton)
        self.headerView.addSubview(self.titleLable)
        self.addSubview(self.headerView)
        self.addSubview(self.tabbleView)
        
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupDelegateTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tabbleView.delegate = delegate
        self.tabbleView.dataSource = dataSource
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            self.headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 40),
            
            self.upArrowButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            self.upArrowButton.centerYAnchor.constraint(equalTo: self.headerView.centerYAnchor),
            
            self.titleLable.leadingAnchor.constraint(equalTo: self.upArrowButton.trailingAnchor, constant: 20),
            self.titleLable.centerYAnchor.constraint(equalTo: self.headerView.centerYAnchor),
            
            self.tabbleView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor),
            self.tabbleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tabbleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tabbleView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    public func insertRowsTableView(indexPath: [IndexPath], section: Int) {
        self.tabbleView.beginUpdates()
        self.tabbleView.insertRows(at: indexPath, with: .fade)
        self.tabbleView.reloadSections(IndexSet(integer: section), with: .none)
        self.tabbleView.endUpdates()
    }
    
    public func deleteRowsTableView(indexPath: [IndexPath], section: Int) {
        self.tabbleView.beginUpdates()
        self.tabbleView.deleteRows(at: indexPath, with: .fade)
        self.tabbleView.reloadSections(IndexSet(integer: section), with: .none)
        self.tabbleView.endUpdates()
    }

}
