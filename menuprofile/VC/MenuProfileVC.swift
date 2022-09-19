//
//  ViewController.swift
//  menuprofile
//
//  Created by Jorge Henrique Chiarelli on 16/09/22.
//

import UIKit

class MenuProfileVC: UIViewController {
    
    var screen: MenuProfileScreen?
    
    let viewModel: MenuProfileViewModel = MenuProfileViewModel()
    
    override func loadView() {
        self.screen = MenuProfileScreen()
        self.view = self.screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate(delegate: self)
        viewModel.fetch(.request)
//        viewModel.fetch(.mock)
    }


}

extension MenuProfileVC: MenuProfileViewModelDelegate {
    func success() {
        print("Tudo certo!")
        self.screen?.setupDelegateTableView(delegate: self, dataSource: self)
        self.screen?.tabbleView.reloadData()
    }
    
    func error(_ message: String) {
        print("Deu erro: \(message)")
    }
    
}

extension MenuProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionView()
        view.referenceButton.addTarget(self, action: #selector(self.tapSection(_:)), for: .touchUpInside)
        view.referenceButton.tag = section
        view.setupSection(description: self.viewModel.titleForSection(section: section))
        view.expandButton(value: self.viewModel.containsSection(section))
        
        return view
    }
    
    @objc func tapSection(_ sender: UIButton) {
        print(#function)
        let section = sender.tag
        if self.viewModel.containsSection(section) {
            self.viewModel.tappedSection(type: .remove, section: section)
            self.screen?.insertRowsTableView(indexPath: self.viewModel.indexPathForSection(section), section: section)
        } else {
            self.viewModel.tappedSection(type: .insert, section: section)
            self.screen?.deleteRowsTableView(indexPath: self.viewModel.indexPathForSection(section), section: section)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
}
