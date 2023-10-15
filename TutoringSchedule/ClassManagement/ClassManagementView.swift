//
//  ClassManagementView.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/06.
//

import UIKit
import RealmSwift

class ClassManagementView: BaseView {

    private let realmRepository = RealmRepository()
    var delegate: sendSelectRowDelegate?
    var data: Results<ClassTable>?
    
    lazy var searchBar = {
        let view = UISearchBar()
        view.placeholder = "수업명"
        view.searchBarStyle = .minimal
        view.delegate = self
        return view
    }()
    
    let lineView = {
       let view = UILabel()
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        return view
    }()

    override func setConfigure() {
        addSubview(searchBar)
        addSubview(lineView)
        addSubview(tableView)
    }
    
    override func setConstraint() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(0.7)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(searchBar)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
    }
    
}

extension ClassManagementView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data else { return UITableViewCell() }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = data[indexPath.row].className
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let classData = data else { return }
        guard var scheduleData = realmRepository.read(ScheduleTable.self) else { return }
        guard let calendarData = realmRepository.read(CalendarTable .self) else { return }
                
        scheduleData = scheduleData.where {
            $0.classPK == classData[indexPath.row]._id
        }
        
        for schedule in scheduleData {

            let calendarFilterData = calendarData.where {
                $0.schedulePK == schedule._id
                
            }.filter {
                Int($0.date.timeIntervalSince(Date())) >= 0
            }

            for data in calendarFilterData {
                realmRepository.delete(data: data)
            }
        }

        for data in scheduleData {
            realmRepository.delete(data: data)
        }
        
        realmRepository.delete(data: classData[indexPath.row])

        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data else { return }
        delegate?.selectRow(data: data[indexPath.row])
    }
}

extension ClassManagementView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let realmData = realmRepository.read(ClassTable.self) else { return }
        
        var tempData = realmData.sorted(by: \.className)
        
        if !searchText.isEmpty {
            tempData = tempData.where {
                $0.className.contains(searchText)
            }
        }
        
        data = tempData
        tableView.reloadData()
    }
}
