//
//  addBookViewController.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/2/24.
//

import UIKit
import SnapKit
import CoreData

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
        add.setTitle("추가", for: .normal)
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
        allDeleteButton.addTarget(self, action: #selector(deleteAllBooks), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addSampleBook), for: .touchUpInside)
    }

    private func setupViews() {
        view.backgroundColor = .white

        [searchResultsLabel, resultView, resultView2, resultView3, allDeleteButton, addButton]
            .forEach { view.addSubview($0) }

        searchResultsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        allDeleteButton.snp.makeConstraints {
            $0.leading.equalTo(searchResultsLabel.snp.trailing).offset(60)
            $0.centerY.equalTo(searchResultsLabel)
        }

        addButton.snp.makeConstraints {
            $0.trailing.equalTo(searchResultsLabel.snp.leading).offset(-60)
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

    // 데이터 저장 함수
    @objc private func addSampleBook() {
        addBookViewController.saveBook(title: "Sample Title", author: "Sample Author")
    }

    // 데이터 삭제 함수
    @objc private func deleteAllBooks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Book.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }

    static func saveBook(title: String, author: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let book = Book(context: context)

        book.title = title
        book.author = author

        do {
            try context.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    static func fetchBooks() -> [Book] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()

        do {
            let books = try context.fetch(fetchRequest)
            return books
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
}
