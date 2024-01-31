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
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgPrimary
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self

        NotificationCenter.default.addObserver(self, selector: #selector(calendarReload), name: .calendarReload, object: nil)
        mainView.todayButton.addTarget(self, action: #selector(todayButtonTapped), for: .touchUpInside)
        
        bind()
        todayButtonTapped()
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
                mainView.yearMonthLabel.text = text
            } else if case .calendarDidSelect(let data) = eventType {
                self.data = data
            }
        }
    }

    @objc func calendarReload() {
        mainView.calendar.reloadData()
    }

    //오늘 날짜로 돌아오기
    @objc func todayButtonTapped() {
        selectDate = Date()
        mainView.calendar.select(selectDate)
        selectDateSetting()
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

        let dayText = "\(Calendar.current.component(.day, from: date))"
        let attributedString = NSMutableAttributedString(string: dayText)
        attributedString.addAttribute(.baselineOffset, value: CGFloat(50), range: NSRange(location: 0, length: attributedString.length))
        cell.titleLabel.attributedText = attributedString
        
        //row line
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: 1))
        label.layer.backgroundColor = UIColor.bdLine.cgColor
        cell.addSubview(label)
        
        if !cell.isPlaceholder {
            //errorHandling
            do {
                let data = try viewModel.calendarWillDisplay(date: date)

                if !data.isEmpty {
                    for (index, item) in data.enumerated() {
                        guard index < 3 else {
                            guard cell.frame.height > 90 else { return }
                            
                            let label = UILabel(frame: CGRect(x: 0, y: 82, width: cell.bounds.width, height: 15))
                            label.font = .customFont(ofSize: 10)
                            label.text = "+\(data.count - 3)"
                            label.textAlignment = .center
                            label.textColor = .bdBlack
                            cell.addSubview(label)
                            return
                        }
                        
                        let y = [30, 48, 66] // 사이 간격: 3
                        let color: [UIColor] = [.pkBlue, .pkBlue2, .pkBlue3]
                        let label = UILabel(frame: CGRect(x: 5, y: y[index], width: Int(cell.bounds.width) - 10, height: 15))
                        label.font = .customFont(ofSize: 10)
                        label.text =  Date.convertToString(format: "HH:mm", date: item.startTime)
                        label.textAlignment = .center
                        label.layer.cornerRadius = 2
                        label.textColor = .bdBlack
                        label.backgroundColor = color[index]
                        label.clipsToBounds = true
                        cell.addSubview(label)
                    }
                }
            } catch let realmError as RealmErrorType {
                let errorDescription = realmError.description
                UIAlertController.customMessageAlert(view: self, title: errorDescription.title, message: errorDescription.message)
            } catch { }
        }
    }
    
    //캘린더 스크롤 감지
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        selectDate = calendar.currentPage
        //mainView.calendar.select(selectDate)
        selectDateSetting()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        selectDate = date
        selectDateSetting()

        let vc = CalendarDetailViewController(date: date)
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        
        present(vc, animated: true)
    }
    
    func selectDateSetting() {
        viewModel.calendarPageChange(date: selectDate)
        
        errorHandling {
            try viewModel.calendarDidSelect(date: selectDate)
        }
    }
}
