//
//  CalendarSearchViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/29.
//

import UIKit
import SnapKit

class CalendarSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let closeButton = {
        let view = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 25)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: configuration)
        view.setImage(image, for: .normal)
        view.tintColor = .systemGray5
        return view
    }()
    
    let titleLabel = {
        let view = UILabel()
        view.text = "검색"
        view.textColor = .black
        view.font = .boldSystemFont(ofSize: 30)
        return view
    }()
    
    let searchBar = {
        let view = UISearchBar()
        view.placeholder = "키워드"
        view.searchBarStyle = .minimal
        return view
    }()
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConfigure()
        setConstraint()
    }
    
    func setConfigure() {
        view.addSubview(closeButton)
        view.addSubview(titleLabel)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    func setConstraint() {
        
        closeButton.snp.makeConstraints { make in
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(15)
            make.size.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(60)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(14)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        headerView.backgroundColor = .white
        
        let dateLabel = UILabel()
        dateLabel.frame = CGRect.init(x: 16, y: 0, width: 120, height: headerView.frame.height)
        dateLabel.font = .boldSystemFont(ofSize: 14)
        dateLabel.textColor = .black
        
        if section == 0{
            dateLabel.text = "2023-09-29 (금)"
        } else {
            dateLabel.text = "2023-09-30 (토)"
        }
        
        headerView.addSubview(dateLabel)
        
        let countLabel = UILabel()
        countLabel.frame = CGRect.init(x: headerView.frame.width - 70, y: 0, width: 80, height: headerView.frame.height)
        countLabel.font = .boldSystemFont(ofSize: 12)
        countLabel.textColor = .lightGray
        
        if section == 0{
            countLabel.text = "1건의 일정"
        } else {
            countLabel.text = "3건의 일정"
        }
        
        headerView.addSubview(countLabel)
        
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "ㅇㅇㅇㅇ"
        return cell
    }
}
