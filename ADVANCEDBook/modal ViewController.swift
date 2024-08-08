//
//  SheetViewController.swift
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

        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        authorLabel.font = .systemFont(ofSize: 16, weight: .medium)
        priceLabel.font = .systemFont(ofSize: 16, weight: .medium)
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.numberOfLines = 0

        thumbnailImageView.contentMode = .scaleAspectFit

        addButton.setTitle("담기", for: .normal)
        addButton.setTitleColor(.white, for: .normal)
        addButton.backgroundColor = .systemGreen
        addButton.layer.cornerRadius = 5
        addButton.addTarget(self, action: #selector(addBook), for: .touchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(thumbnailImageView)
        view.addSubview(priceLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(addButton)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        thumbnailImageView.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(200)
        }

        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnailImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        addButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(44)
        }
    }

    private func configureView() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: ", ")  // 옵셔널이 아닌 배열에서 옵셔널 체이닝 제거
        priceLabel.text = "\(book.price)원"
        descriptionLabel.text = book.description
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
}
