//
//  ViewController.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/2/24.
//

import UIKit
import SnapKit

class MainViewcontroller: UIViewController {



    let searchbar : UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "책 검색"
        search.barStyle = .default
        search.searchBarStyle = .minimal
        search.barTintColor = .black
        search.searchTextField.textColor = .black
        return search
    }()

    let searchResultsLabel : UILabel = {
        let searchResults = UILabel()
        searchResults.text = "검색 결과"
        searchResults.textColor = .black
        searchResults.font = .systemFont(ofSize: 35, weight: .bold)
        return searchResults
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    private func setupViews() {
        view.backgroundColor = .white

        [searchbar, searchResultsLabel]//addSubview 코드 한번에 모으기
            .forEach {view.addSubview($0)}

        searchbar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).inset(16)
        }
        searchResultsLabel.snp.makeConstraints {
            $0.top.equalTo(searchbar.snp.bottom).offset(16)
            $0.leading.equalTo(view).offset(16)
        }

    }
}

