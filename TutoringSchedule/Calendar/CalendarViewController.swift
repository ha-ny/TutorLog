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
    var calendarMonth = Date()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        
        bind()
        
        NotificationCenter.default.addObserver(self, selector: #selector(calendarReload), name: .calendarReload, object: nil)
        
        appVersionCheck()
    }
    
    private func appVersionCheck() {
        AppVersionCheck.updateRequired { url in
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                if let url {
                    UIAlertController.customMessageAlert(view: self, title: "appVersionCheckTitle".localized, message: "appVersionCheckMessage".localized) {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:]) { _ in
                                //exit(0)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func bind() {
        viewModel.state.bind { [weak self] eventType in
            guard let self else { return }
            
            if case .calendarPageChange(let text) = eventType {
                mainView.dateLabel.text = text
            } else if case .calendarDidSelect(let data) = eventType {
                self.data = data
                //mainView.tableView.reloadData()
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
        calendar(mainView.calendar, didSelect: calendarMonth, at: .current)
    }
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let weekday = Calendar.current.component(.weekday, from: date)
        return weekday == 1 ? .bdRed : (weekday == 7 ? .bdBlue : .bdBlack)
    }

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        for subview in cell.subviews {
            if let _ = subview as? UILabel {
                subview.removeFromSuperview()
            }
        }
        
        cell.titleLabel.alpha = cell.isPlaceholder ? 0.4 : 1
        
        //숫자 위치 조정
        let today = Date.convertToString(format: "fullDateFormat".localized, date: Date())
        let calendardDay = Date.convertToString(format: "fullDateFormat".localized, date: date)
        if today == calendardDay {
            //attributedString = NSMutableAttributedString(string: "오늘")
//            cell.titleLabel.textColor = .systemOrange
//            cell.titleLabel.font = .boldSystemFont(ofSize: 15)
        }
        
        let dayText = "\(Calendar.current.component(.day, from: date))"
        let attributedString = NSMutableAttributedString(string: dayText)
        attributedString.addAttribute(.baselineOffset, value: CGFloat(50), range: NSRange(location: 0, length: attributedString.length))
        cell.titleLabel.attributedText = attributedString
        
        //row line
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: 1))
        label.layer.backgroundColor = UIColor.bdLine.cgColor
        cell.addSubview(label)
        
        //errorHandling
        do {
            //guard let data = try viewModel.calendarWillDisplay(date: date) else { return }
            
            if !cell.isPlaceholder {
                let data = ["14:00", "15:00", "18:00", "20:00", "23:30"]
                for (index, item) in data.enumerated() {
                    guard index < 3 else {
                        guard cell.frame.height > 90 else { return }
                        let label = UILabel(frame: CGRect(x: 0, y: 82, width: cell.bounds.width, height: 15))
                        label.font = .systemFont(ofSize: 10)
                        label.text = "+\(data.count - 3)"
                        label.textAlignment = .center
                        label.textColor = .bdBlack
                        cell.addSubview(label)
                        return
                    }

                    let y = [30, 48, 66] //사이 간격: 3
                    let color: [UIColor] = [.pkRed, .pkBlue, .pkYellow]
                    let label = UILabel(frame: CGRect(x: 5, y: y[index], width: Int(cell.bounds.width) - 10, height: 15))
                    label.font = .systemFont(ofSize: 10)
                    label.text = item //String(Date.convertToString(format: "HH:mm", date: item.startTime ?? Date()))
                    label.textAlignment = .center
                    label.layer.cornerRadius = 2
                    label.textColor = .bdBlack
                    label.backgroundColor = color.randomElement()
                    label.clipsToBounds = true
                    cell.addSubview(label)
                }
            }
        } catch let realmError as RealmErrorType {
            let errorDescription = realmError.description
            UIAlertController.customMessageAlert(view: self, title: errorDescription.title, message: errorDescription.message)
        } catch { }
    }
    
    //캘린더 스크롤 감지
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1), to: calendar.currentPage)!
        calendarMonth = endOfMonth
        selectDateSetting()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectDateSetting()
    }
    
    func selectDateSetting() {
//        viewModel.calendarPageChange(date: calendarMonth)
//        
//        errorHandling {
//            try viewModel.calendarDidSelect(date: calendarMonth)
//        }
    }
}

//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let selectDate = mainView.calendar.selectedDate else { return UITableViewCell() }
//        guard let data else { return UITableViewCell() }
//
//        //errorHandling
//        do {
//            guard let cellSetting = try viewModel.cellSetting(data: data[indexPath.row], selectDate: selectDate) else { return UITableViewCell() }
//            let classData = cellSetting.classData
//
//            guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: String(describing: CalendarTableViewCell.self)) as? CalendarTableViewCell else { return UITableViewCell() }
//            cell.setting()
//            cell.timeLabel.text = cellSetting.time
//            cell.classNameLabel.text = classData.className
//            cell.tutoringPlaceLabel.text = classData.tutoringPlace
//
//            if classData.tutoringPlace.isEmpty {
//                cell.centerYClassNameLabel()
//            }
//
//            cell.selectionStyle = .none
//            return cell
//        } catch let realmError as RealmErrorType {
//            let errorDescription = realmError.description
//            UIAlertController.customMessageAlert(view: self, title: errorDescription.title, message: errorDescription.message)
//        } catch { }
//
//        return UITableViewCell()
//    }
//}
