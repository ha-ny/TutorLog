//
//  CalendarViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    private let viewModel = CalendarViewModel()
    let mainView = CalendarView()
    
    var data: [CalendarTable]?
    var selectDate = Date()
    var isTodayButtonTap = false
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        mainView.todayButton.addTarget(self, action: #selector(todayButtonTapped), for: .touchUpInside)
        //mainView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        mainView.tableView.register(CalendarTableViewCell.self, forCellReuseIdentifier: String(describing: CalendarTableViewCell.self))
        
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        
        bind()
        todayButtonTapped()
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        NotificationCenter.default.addObserver(self, selector: #selector(calendarReload), name: .calendarReload, object: nil)
    }
    
    func bind() {
        viewModel.state.bind { [weak self] eventType in
            guard let self else { return }
            
            if case .calendarPageChange(let text) = eventType {
                mainView.yearMonthLabel.text = text
            } else if case .calendarDidSelect(let data) = eventType {
                self.data = data
                mainView.tableView.reloadData()
            }
        }
    }
    
    @objc func didSwipeView(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .up {
            mainView.calendar.scope = .week
        }
        else if sender.direction == .down {
            mainView.calendar.scope = .month
        }
    }
    
    @objc func calendarReload() {
        mainView.calendar.reloadData()
        calendar(mainView.calendar, didSelect: selectDate, at: .current)
    }
    
    //    @objc func searchButtonTapped() {
    //        let vc = CalendarSearchViewController()
    //        present(vc, animated: true)
    //    }
    
    //오늘 날짜로 돌아오기
    @objc func todayButtonTapped() {
        isTodayButtonTap = true
        
        selectDate = Date()
        mainView.calendar.select(selectDate)
        selectDateSetting()
    }
}

extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let selectDate = mainView.calendar.selectedDate else { return UITableViewCell() }
        guard let data else { return UITableViewCell() }
        
        //errorHandling
        do {
            guard let cellSetting = try viewModel.cellSetting(data: data[indexPath.row], selectDate: selectDate) else { return UITableViewCell() }
            let classData = cellSetting.classData
            
            guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: String(describing: CalendarTableViewCell.self)) as? CalendarTableViewCell else { return UITableViewCell() }
            cell.setting()
            cell.timeLabel.text = cellSetting.time
            cell.classNameLabel.text = classData.className
            cell.tutoringPlaceLabel.text = classData.tutoringPlace
            
            classData.tutoringPlace.isEmpty ? cell.centerYClassNameLabel() : ()
            cell.selectionStyle = .none
            return cell
        } catch let realmError as RealmErrorType {
            let errorDescription = realmError.description
            UIAlertController.customMessageAlert(view: self, title: errorDescription.title, message: errorDescription.message)
        } catch { }
        
        return UITableViewCell()
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let day = Calendar.current.component(.weekday, from: date) - 1
        
        if day == 0 {
            return .systemRed
        } else if day == 6 {
            return .systemBlue
        } else {
            return .black
        }
    }
    
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        for subview in cell.subviews {
            if subview is UILabel {
                subview.removeFromSuperview()
            }
        }
        
        //errorHandling
        do {
            guard let data = try viewModel.calendarWillDisplay(date: date) else { return }
            
            if !data.isEmpty {
                let label = UILabel(frame: CGRect(x: 28, y: 25, width: 14, height: 14))
                label.layer.backgroundColor = UIColor.signatureColor.cgColor
                label.layer.cornerRadius = 6
                label.font = .boldSystemFont(ofSize: 9)
                label.textAlignment = .center
                label.textColor = .white
                
                label.text = "\(data.count)"
                cell.addSubview(label)
            }
        } catch let realmError as RealmErrorType {
            let errorDescription = realmError.description
            UIAlertController.customMessageAlert(view: self, title: errorDescription.title, message: errorDescription.message)
        } catch { }
    }
    
    //캘린더 스크롤 감지
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        if !isTodayButtonTap {
            selectDate = calendar.currentPage
            mainView.calendar.select(selectDate)
            selectDateSetting()
        } else { isTodayButtonTap.toggle() }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectDate = date
        selectDateSetting()
    }
    
    func selectDateSetting() {
        viewModel.calendarPageChange(date: selectDate)
        mainView.selectDateLabel.text =  "📝 \(Date.convertToString(format: "fullDateFormat".localized, date: selectDate)) "
        
        errorHandling {
            try viewModel.calendarDidSelect(date: selectDate)
        }
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        mainView.setCalendarHeight(height: bounds.height)
    }
}
