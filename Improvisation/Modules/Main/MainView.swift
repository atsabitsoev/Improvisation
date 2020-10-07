//
//  MainView.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 06.10.2020.
//

import UIKit

final class MainView: UIViewController, MainViewDelegate {
    
    private let presenter = MainPresenter(apiService: ApiService())
    
    private var items: [CellItem] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setMainViewDelegate(self)
        title = "Главная"
        setupTableView()
        view.backgroundColor = .white
        view.setNeedsUpdateConstraints()
        presenter.viewDidLoad()
    }
    
    override func updateViewConstraints() {
        setupTableViewConstraints()
        super.updateViewConstraints()
    }
    
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ок", style: .default, handler: { _ in
            if let selectedCellIndexPath = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: selectedCellIndexPath, animated: true)
            }
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNewItems(_ items: [CellItem]) {
        self.items = items
        tableView.reloadData()
    }
    
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(HzCell.self, forCellReuseIdentifier: HzCell.identifier)
        tableView.register(PictureCell.self, forCellReuseIdentifier: PictureCell.identifier)
        tableView.register(SelectorCell.self, forCellReuseIdentifier: SelectorCell.identifier)
    }
    
    private func setupTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

// MARK: TableView Delegate
extension MainView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentItem = items[indexPath.row]
        switch currentItem {
        case .hzCellItem(name: _, item: let hzCellItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: HzCell.identifier) as! HzCell
            cell.configure(withItem: hzCellItem)
            return cell
        case .pictureCellItem(name: _, item: let pictureCellItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: PictureCell.identifier) as! PictureCell
            cell.configure(withItem: pictureCellItem)
            return cell
        case .selectorCellItem(name: let name, item: let selectorCellItem):
            let cell = tableView.dequeueReusableCell(withIdentifier: SelectorCell.identifier) as! SelectorCell
            cell.configure(name: name, withItem: selectorCellItem, indexPathRow: indexPath.row, delegate: self)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCellItem = items[indexPath.row]
        switch selectedCellItem {
        case .selectorCellItem(item: _):
            return
        default:
            break
        }
        presenter.actionDone(item: selectedCellItem)
    }
}

//MARK: SelectorCell Delegate
extension MainView: SelectorCellDelegate {
    func selectedVariantChanged(item: SelectorCellItem,
                                name: String,
                                indexPathRow: Int) {
        let cellItem = CellItem.selectorCellItem(name: name, item: item)
        items[indexPathRow] = cellItem
        presenter.actionDone(item: cellItem)
    }
}
