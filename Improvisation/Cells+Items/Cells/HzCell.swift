//
//  HzCell.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 06.10.2020.
//

import UIKit


final class HzCell: UITableViewCell {
    
    static let identifier = "HzCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupLabelConstraints()
        super.updateConstraints()
    }
    
    
    func configure(withItem item: HzCellItem) {
        label.text = item.text
    }
    
    
    private func setupCell() {
        contentView.addSubview(label)
        setNeedsUpdateConstraints()
    }
    
    private func setupLabelConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
}
