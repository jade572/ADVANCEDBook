//
//  ModalViewController.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/8/24.
//

import UIKit
import SnapKit

class ModalViewController: UIViewController {

    private let titleLabel = UILabel()
    private let authorLabel = UILabel()
    private let priceLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let thumbnailImageView = UIImageView()
    private let addButton = UIButton()
    private let cancelButton = UIButton()

    var book: BookModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        configureView()
    }

    private func setupViews() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 10

        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center

        authorLabel.font = .systemFont(ofSize: 16, weight: .medium)
        authorLabel.textColor = .lightGray
        authorLabel.textAlignment = .center

        priceLabel.font = .systemFont(ofSize: 18, weight: .medium)
        priceLabel.textAlignment = .center

        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center

        thumbnailImageView.contentMode = .scaleAspectFit
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.clipsToBounds = true

        addButton.setTitle("담기", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemGreen
        addButton.layer.cornerRadius = 10
        addButton.addTarget(self, action: #selector(addBook), for: .touchUpInside)

        cancelButton.setTitle("X", for: .normal)
        cancelButton.setTitleColor(.white, for: .normal)
        cancelButton.backgroundColor = .lightGray
        cancelButton.layer.cornerRadius = 10
        cancelButton.addTarget(self, action: #selector(cancel), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(thumbnailImageView)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(addButton)
        view.addSubview(cancelButton)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(300)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }

        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.width.height.equalTo(50)
        }
    }

    private func configureView() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")
        priceLabel.text = "\(book.price)원"  // 가격을 표시하는 부분
        descriptionLabel.text = book.contents ?? "설명이 없습니다."

        if let thumbnail = book.thumbnail, let url = URL(string: thumbnail) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.thumbnailImageView.image = UIImage(data: data)
                    }
                }
            }
        }
    }

    @objc private func addBook() {
        guard let book = book else { return }
        AddBookViewController.saveBook(title: book.title, author: book.authors.joined(separator: ", "), price: book.price) {
            DispatchQueue.main.async {
                NotificationCenter.default.post(name: NSNotification.Name("bookAdded"), object: nil)
            }
        }
        dismiss(animated: true, completion: nil)
    }

    @objc private func cancel() {
        dismiss(animated: true, completion: nil)
    }
}
