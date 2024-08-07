//
//  SheetViewController.swift
//  ADVANCEDBook
//
//  Created by 이진규 on 8/8/24.
//

import UIKit

class modalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        let label = UILabel()
        label.text = "모달 뷰입니다"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(label)

        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
