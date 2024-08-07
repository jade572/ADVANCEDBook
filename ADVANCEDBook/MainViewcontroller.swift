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
        result.layer.borderColor = UIColor.black.cgColor
        result.layer.borderWidth = 1
        return result
    }()

    let resultView2: UIView = {
        let result2 = UIView()
        result2.layer.borderColor = UIColor.black.cgColor
        result2.layer.borderWidth = 1
        return result2
    }()

    let resultView3: UIView = {
        let result3 = UIView()
        result3.layer.borderColor = UIColor.black.cgColor
        result3.layer.borderWidth = 1
        return result3
    }()

    let modalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show Modal", for: .normal)
        button.addTarget(self, action: #selector(presentSheet), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .white

        [searchbar, searchResultsLabel, resultView, resultView2, resultView3, modalButton]
            .forEach { view.addSubview($0) }

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
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }

        resultView2.snp.makeConstraints {
            $0.top.equalTo(resultView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }

        resultView3.snp.makeConstraints {
            $0.top.equalTo(resultView2.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }

        modalButton.snp.makeConstraints {
            $0.top.equalTo(resultView3.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
    }

    @objc private func presentSheet() {
        let sheetVC = modalViewController()

        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.large()]
            sheet.prefersGrabberVisible = true
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
        }

        present(sheetVC, animated: true, completion: nil)
    }
}
