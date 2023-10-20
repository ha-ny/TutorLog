//
//  CalendarViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import RealmSwift

class CalendarViewController: UIViewController {
   
    private let realmRepository = RealmRepository()
    let mainView = CalendarView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        mainView.todayButton.addTarget(self, action: #selector(todayButtonTapped), for: .touchUpInside)
        //mainView.searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        
        todayButtonTapped()
        
        NotificationCenter.default.addObserver(self, selector: #selector(calendarReload), name: .calendarReload, object: nil)
    }
    
    @objc func calendarReload() {
        mainView.calendar.reloadData()
    }
   
//    @objc func searchButtonTapped() {
//        let vc = CalendarSearchViewController()
//        present(vc, animated: true)
//    }
    
    //오늘 날짜로 돌아오기
    @objc func todayButtonTapped() {
        mainView.calendar.select(Date())
        mainView.calendar(mainView.calendar, didSelect: Date(), at: .current)
    }
}
