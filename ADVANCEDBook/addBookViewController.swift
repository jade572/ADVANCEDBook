//
//  HomeController.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/2/24.
//
import UIKit
import SnapKit

class addBookViewController: UIViewController {

    let searchResultsLabel : UILabel = {
        let searchResults = UILabel()
        searchResults.text = "담은 책"
        searchResults.textColor = .black
        searchResults.font = .systemFont(ofSize: 35, weight: .bold)
        return searchResults
    }()

    let allDeleteButton : UIButton = {
        let allDelete = UIButton()
        allDelete.setTitle("전체삭제", for: .normal)
        allDelete.setTitleColor(.blue, for: .normal)
        return allDelete
    }()

    let addButton : UIButton = {
        let add = UIButton()
        add.setTitle("전체삭제", for: .normal)
        add.setTitleColor(.blue, for: .normal)
        return add
    }()

    let resultView : UIView = {
        let result = UIView()
        result.layer.borderColor = UIColor.black.cgColor
        result.layer.borderWidth = 1
        return result
    }()


    let resultView2 : UIView = {
        let result2 = UIView()
        result2.layer.borderColor = UIColor.black.cgColor
        result2.layer.borderWidth = 1
        return result2
    }()

    let resultView3 : UIView = {
        let result3 = UIView()
        result3.layer.borderColor = UIColor.black.cgColor
        result3.layer.borderWidth = 1
        return result3
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    private func setupViews() {
        view.backgroundColor = .white

        [searchResultsLabel, resultView, resultView2, resultView3,
         allDeleteButton, addButton]//addSubview 코드 한번에 모으기
            .forEach {view.addSubview($0)}


        searchResultsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            //$0.top.equalTo(view.snp.top).offset(55)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)

        }
        allDeleteButton.snp.makeConstraints {
            $0.trailing.equalTo(searchResultsLabel.snp.leading).inset(50)
            $0.centerY.equalTo(searchResultsLabel)
        }
        addButton.snp.makeConstraints {
            $0.leading.equalTo(searchResultsLabel.snp.trailing).offset(50)
            $0.centerY.equalTo(searchResultsLabel)
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
    }
}


