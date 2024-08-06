////
////  mainViewcontroller.swift
////  ADVANCEDBook
////
////  Created by 이진규 on 8/6/24.
//// 최근 본 책, 아래 라인
////
//
//
//import UIKit
//import SnapKit
//
//class mainViewcontroller: UIViewController {
//
//
//
//    let searchbar : UISearchBar = {
//        let search = UISearchBar()
//        search.placeholder = "책 검색"
//        search.barStyle = .default
//        search.searchBarStyle = .minimal
//        search.barTintColor = .black
//        search.searchTextField.textColor = .black
//        return search
//    }()
//
//    let searchResultsLabel : UILabel = {
//        let searchResults = UILabel()
//        searchResults.text = "검색 결과"
//        searchResults.textColor = .black
//        searchResults.font = .systemFont(ofSize: 35, weight: .bold)
//        return searchResults
//    }()
//
//    let resultView : UIView = {
//        let result = UIView()
//        result.layer.borderColor = UIColor.black.cgColor
//        result.layer.borderWidth = 1
//        return result
//    }()
//
//
//    let resultView2 : UIView = {
//        let result2 = UIView()
//        result2.layer.borderColor = UIColor.black.cgColor
//        result2.layer.borderWidth = 1
//        return result2
//    }()
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            setupViews()
//        }
//        private func setupViews() {
//            view.backgroundColor = .white
//
//            [searchbar, searchResultsLabel, resultView, resultView2]//addSubview 코드 한번에 모으기
//                .forEach {view.addSubview($0)}
//
//            searchbar.snp.makeConstraints {
//                $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//                $0.leading.equalToSuperview().offset(16)
//                $0.trailing.equalToSuperview().inset(16)
//            }
//
//            searchResultsLabel.snp.makeConstraints {
//                $0.top.equalTo(searchbar.snp.bottom).offset(16)
//                $0.leading.equalToSuperview().offset(16)
//            }
//            resultView.snp.makeConstraints {
//                $0.top.equalTo(searchResultsLabel.snp.bottom).offset(16)
//                $0.leading.equalToSuperview().inset(16)
//                $0.trailing.equalToSuperview().inset(16)
//                $0.height.equalTo(60)
//
//            }
//            resultView2.snp.makeConstraints {
//                $0.top.equalTo(resultView.snp.bottom).offset(16)
//                $0.leading.equalToSuperview().inset(16)
//                $0.trailing.equalToSuperview().inset(16)
//                $0.height.equalTo(60)
//
//            }
//        }
//    }
//
//
