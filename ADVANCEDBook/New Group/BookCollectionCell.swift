//
//  BookCollectionCell.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/9/24.
//

import UIKit
import SnapKit

class BookCollectionCell: UICollectionViewCell {
    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let priceLabel = UILabel()
    private let thumbnailImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Set the content mode and size constraints for the thumbnail image
        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50) // Set the size of the image
        }
        
        // Set font properties for the labels
        titleLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 1 // Restrict text to a single line
        titleLabel.lineBreakMode = .byTruncatingTail // Truncate long text
        
        authorLabel.font = .systemFont(ofSize: 14, weight: .regular)
        authorLabel.numberOfLines = 1 // Restrict text to a single line
        authorLabel.lineBreakMode = .byTruncatingTail // Truncate long text
        
        priceLabel.font = .systemFont(ofSize: 14, weight: .regular)
        priceLabel.textAlignment = .right
        
        // Arrange title, author, and price labels in a horizontal stack
        let infoStackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel, priceLabel])
        infoStackView.axis = .horizontal
        infoStackView.spacing = 4
        infoStackView.alignment = .leading
        
        // Arrange the thumbnail and info stack view in a vertical stack
        let containerStackView = UIStackView(arrangedSubviews: [thumbnailImageView, infoStackView])
        containerStackView.axis = .vertical
        containerStackView.spacing = 8
        containerStackView.alignment = .leading
        
        // Add the container stack view to the content view
        contentView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        // Set border and corner properties for the cell
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
    }
    
    func configure(with book: BookModel) {
        // Configure the cell with the book data
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        priceLabel.text = "\(book.price)원"
        
        
        if let thumbnail = book.thumbnail, let url = URL(string: thumbnail) {
            DispatchQueue.global(qos: .userInitiated).async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }
}
