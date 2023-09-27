//
//  ViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        label.textColor = .black
        label.text = "test_name".localized
    }
}
