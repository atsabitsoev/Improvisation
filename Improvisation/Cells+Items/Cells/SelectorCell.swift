//
//  SelectorCell.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 07.10.2020.
//

import UIKit


protocol SelectorCellDelegate {
    func selectedVariantChanged(item: SelectorCellItem, name: String, indexPathRow: Int)
}


final class SelectorCell: UITableViewCell {
    
    static let identifier = "SelectorCell"
    
    private var item: SelectorCellItem!
    private var selectorCellDelegate: SelectorCellDelegate?
    private var indexPathRow: Int!
    private var name: String!
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupSegmentedControlConstraints()
        super.updateConstraints()
    }
    
    
    func configure(name: String,
                   withItem item: SelectorCellItem,
                   indexPathRow: Int,
                   delegate: SelectorCellDelegate) {
        self.item = item
        selectorCellDelegate = delegate
        self.indexPathRow = indexPathRow
        self.name = name
        
        let variants = item.variants
        for (index, segment) in variants.enumerated() {
            segmentedControl.insertSegment(withTitle: segment.text, at: index, animated: false)
        }
        let selectedIndex = variants.firstIndex { (variant) -> Bool in
            return variant.id == item.selectedId
        }
        segmentedControl.selectedSegmentIndex = selectedIndex ?? 0
    }
    
    
    private func setupCell() {
        contentView.addSubview(segmentedControl)
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        selectionStyle = .none
        setNeedsUpdateConstraints()
    }
    
    private func setupSegmentedControlConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            segmentedControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    @objc private func segmentChanged() {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        let selectedVariantId = item.variants[selectedIndex].id
        item.selectedId = selectedVariantId
        selectorCellDelegate?.selectedVariantChanged(item: item, name: name, indexPathRow: indexPathRow)
    }
    
    
}
