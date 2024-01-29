//
//  CalendarDetailViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 1/24/24.
//

import UIKit

class CalendarDetailViewController: UIViewController {

    private let mainView = CalendarDetailView()
    private let viewModel = CalendarDetailViewModel()
    private var data = [DetailData]()
    
    init(date: Date) {
        super.init(nibName: nil, bundle: nil)
        mainView.dateLabel.text = Date.convertToString(format: "fullDateFormat".localized, date: date)
        
        errorHandling {
            data = try viewModel.result(date: date)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: String(describing: CalendarTableViewCell.self))

        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.reloadData()
    }
}

extension CalendarDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //errorHandling
        do {
            guard !data.isEmpty, let cell = mainView.tableView.dequeueReusableCell(withIdentifier: String(describing: CalendarTableViewCell.self)) as? CalendarTableViewCell else { return UITableViewCell() }

            let result = data[indexPath.row]
            let startTime = Date.convertToString(format: "HH:mm", date: result.startTime)
            let endTime = Date.convertToString(format: "HH:mm", date: result.endTime)
            cell.timeLabel.text = "\(startTime) ~ \(endTime)"
            cell.classNameLabel.text = result.classData.className
            cell.tutoringPlaceLabel.text = result.classData.tutoringPlace

            if result.classData.tutoringPlace.isEmpty {
                cell.centerYClassNameLabel()
            }

            cell.selectionStyle = .none
            return cell
        }
    }
}
