//
//  View.swift
//  Viper Architecture
//
//  Created by Murad Yarmamedov on 13.12.23.
//

import Foundation
import UIKit
import SnapKit

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func update(with crypto: [Crypto])
    func update(with error: String)
}

class CryptoViewController: UIViewController, AnyView {
    var presenter: AnyPresenter?
    var cryptos: [Crypto] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self,
                       forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setConstraints()
    }
    
    private func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func setConstraints(){
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func update(with crypto: [Crypto]) {
        print("success")
        DispatchQueue.main.async {
            self.cryptos = crypto
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    func update(with error: String) {
        print(error)
    }
}

extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        return cell
    }
}

