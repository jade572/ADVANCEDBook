//
//  BookCollectionCell.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/9/24.
//

import UIKit
import SnapKit

class BookCollectionCell: UICollectionViewCell {
    private let thumbnailImageView = UIImageView()
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let priceLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        thumbnailImageView.contentMode = .scaleAspectFit

        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail

        authorLabel.font = .systemFont(ofSize: 14, weight: .regular)
        authorLabel.numberOfLines = 1
        authorLabel.lineBreakMode = .byTruncatingTail

        priceLabel.font = .systemFont(ofSize: 14, weight: .regular)
        priceLabel.textAlignment = .left

        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(priceLabel)

        thumbnailImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60) // 이미지 크기를 더 크게 설정
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalTo(thumbnailImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.left.equalTo(thumbnailImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(4)
            make.left.equalTo(thumbnailImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
        }
    }

    func configure(with book: BookModel) {
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        priceLabel.text = "\(book.price)원"

        if let thumbnail = book.thumbnail, let url = URL(string: thumbnail) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            }
        } else {
            thumbnailImageView.image = nil
        }
    }
}
