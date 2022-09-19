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
        self.screen?.setupDelegateTableView(delegate: self, dataSource: self)
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
    }
    
    func error(_ message: String) {
        print("Deu erro: \(message)")
    }
    
}

extension MenuProfileVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionView()
        view.referenceButton.addTarget(self, action: #selector(self.tapSection(_:)), for: .touchUpInside)
        view.referenceButton.tag = section
        view.setupSection(description: "Teste")
        
        return view
    }
    
    @objc func tapSection(_ sender: UIButton) {
        print(#function)
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
