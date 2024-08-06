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
        return search
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    private func setupViews() {
        view.backgroundColor = .white

        [searchbar]//addSubview 코드 한번에 모으기
            .forEach {view.addSubview($0)}

        searchbar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).inset(16)
        }



    }
}
