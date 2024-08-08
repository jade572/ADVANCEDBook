//
//  ViewController.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/2/24.
//
import UIKit
import SnapKit

class MainViewController: UIViewController {

    let searchbar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "책 검색"
        search.barStyle = .default
        search.searchBarStyle = .minimal
        search.barTintColor = .black
        search.searchTextField.textColor = .black
        return search
    }()

    let searchResultsLabel: UILabel = {
        let searchResults = UILabel()
        searchResults.text = "검색 결과"
        searchResults.textColor = .black
        searchResults.font = .systemFont(ofSize: 35, weight: .bold)
        return searchResults
    }()

    let resultView: UIView = {
        let result = UIView()
        result.layer.borderColor = UIColor.clear.cgColor
        result.layer.borderWidth = 1
        return result
    }()

    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BookCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    var books: [BookModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        searchbar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func setupViews() {
        view.backgroundColor = .white

        [searchbar, searchResultsLabel, resultView]
            .forEach { view.addSubview($0) }

        resultView.addSubview(collectionView)

        searchbar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().inset(16)
        }

        searchResultsLabel.snp.makeConstraints {
            $0.top.equalTo(searchbar.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }

        resultView.snp.makeConstraints {
            $0.top.equalTo(searchResultsLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
        }

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func searchBooks(query: String) {
        NetworkManager.shared.fetchBooks(query: query) { [weak self] result in
            switch result {
            case .success(let books):
                self?.books = books
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching books: \(error)")
            }
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        searchBooks(query: query)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookCollectionCell
        let book = books[indexPath.item]
        cell.configure(with: book)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let book = books[indexPath.item]
        let modalVC = ModalViewController()
        modalVC.book = book
        if let sheet = modalVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }
        present(modalVC, animated: true, completion: nil)
    }
}

