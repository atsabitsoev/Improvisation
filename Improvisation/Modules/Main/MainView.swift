//
//  MainView.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 06.10.2020.
//

import UIKit

final class MainView: UIViewController, MainViewDelegate {
    
    private let presenter = MainPresenter(apiService: ApiService())
    
    fileprivate var items: [CellItem] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setMainViewDelegate(self)
        setupTableView()
        view.setNeedsUpdateConstraints()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HzCell.self, forCellReuseIdentifier: HzCell.identifier)
        tableView.register(PictureCell.self, forCellReuseIdentifier: PictureCell.identifier)
        tableView.register(SelectorCell.self, forCellReuseIdentifier: SelectorCell.identifier)
    }
    
}

// MARK: TableView Delegate
extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = items[indexPath.row]
        switch currentItem {
        case .hzCellItem(item: let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: HzCell.identifier) as! HzCell
            cell.configure(withItem: item)
            return cell
        case .pictureCellItem(item: let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifier) as! PictureCell
            cell.configure(withItem: item)
            return cell
        case .selectorCellItem(item: let item):
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectorCell.identifier) as! SelectorCell
            cell.configure(withItem: item, delegate: self)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
}

//MARK: SelectorCell Delegate
extension MainView: SelectorCellDelegate {
    func selectedVariantChanged(id: Int, text: String) {
        <#code#>
    }
}
