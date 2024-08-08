//
//  addBookViewController.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/2/24.
//
import UIKit
import CoreData
import SnapKit

class AddBookViewController: UIViewController {

    let searchResultsLabel: UILabel = {
        let searchResults = UILabel()
        searchResults.text = "담은 책"
        searchResults.textColor = .black
        searchResults.font = .systemFont(ofSize: 35, weight: .bold)
        return searchResults
    }()

    let allDeleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("전체삭제", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookTableCell.self, forCellReuseIdentifier: "BookTableCell")
        return tableView
    }()

    var books: [Book] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchBooks()
        tableView.dataSource = self
        tableView.delegate = self
        allDeleteButton.addTarget(self, action: #selector(deleteAllBooks), for: .touchUpInside)

        NotificationCenter.default.addObserver(self, selector: #selector(bookAdded), name: NSNotification.Name("bookAdded"), object: nil)
    }

    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(searchResultsLabel)
        view.addSubview(allDeleteButton)
        view.addSubview(tableView)

        searchResultsLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }

        allDeleteButton.snp.makeConstraints {
            $0.leading.equalTo(searchResultsLabel.snp.trailing).offset(60)
            $0.centerY.equalTo(searchResultsLabel)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchResultsLabel.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    @objc private func bookAdded() {
        fetchBooks()
    }

    func fetchBooks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()

        do {
            books = try context.fetch(fetchRequest)
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    static func saveBook(title: String, author: String, price: Int, completion: @escaping () -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Book", in: context)!
        let book = NSManagedObject(entity: entity, insertInto: context) as! Book

        book.title = title
        book.author = author
        book.price = String(price)

        do {
            try context.save()
            completion()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    @objc func deleteAllBooks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Book.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            books.removeAll()
            tableView.reloadData()
        } catch let error as NSError {
            print("Could not delete. \(error), \(error.userInfo)")
        }
    }
}

extension AddBookViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookTableCell", for: indexPath) as! BookTableCell
        let book = books[indexPath.row]
        cell.configure(with: BookModel(
            title: book.title ?? "",
            authors: [book.author ?? ""],
            contents: book.description,  // description 필드를 먼저 사용
            price: Int(book.price ?? "0") ?? 0,
            thumbnail: nil
        ))
        return cell
    }
}










