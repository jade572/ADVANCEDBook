//
//  BookTableCell.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/9/24.
//

import UIKit
import SnapKit

class BookTableCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let priceLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        authorLabel.font = .systemFont(ofSize: 14, weight: .regular)
        priceLabel.font = .systemFont(ofSize: 14, weight: .regular)
        priceLabel.textAlignment = .right

        let stackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }

    func configure(with book: BookModel) {
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        priceLabel.text = "\(book.price)원"
    }
}
