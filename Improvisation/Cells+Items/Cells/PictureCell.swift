//
//  PictureCell.swift
//  Improvisation
//
//  Created by Ацамаз Бицоев on 07.10.2020.
//

import SDWebImage

final class PictureCell: UITableViewCell {
    
    static let identifier = "PictureCell"

    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private let pictureView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        setupHorizontalStackConstraints()
        setupPictureViewConstraints()
        super.updateConstraints()
    }
    
    
    func configure(withItem item: PictureCellItem) {
        label.text = item.text
        pictureView.sd_setImage(with: URL(string: item.url))
    }
    
    
    private func setupCell() {
        contentView.addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(pictureView)
        horizontalStack.addArrangedSubview(label)
        setNeedsUpdateConstraints()
    }
    
    private func setupHorizontalStackConstraints() {
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            horizontalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            horizontalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            horizontalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupPictureViewConstraints() {
        NSLayoutConstraint.activate([
            pictureView.heightAnchor.constraint(equalToConstant: 32),
            pictureView.widthAnchor.constraint(equalToConstant: 32)
        ])
    }
}
