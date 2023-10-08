//
//  TabBarViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import SnapKit

class TabBarViewController: UIViewController {

    let tabBar = {
        let view = UITabBarController()
        view.tabBar.tintColor = .black
        view.viewControllers = {
            
            let log = UINavigationController(rootViewController: UIViewController())
            log.tabBarItem = UITabBarItem(title: "LogCalendarTabName".localized, image: UIImage(systemName: "book.closed"), tag: 0)
            
            let calendar = CalendarViewController()
            calendar.tabBarItem = UITabBarItem(title: "CalendarTabName".localized, image: UIImage(systemName: "calendar"), tag: 0)
            
            let student = UINavigationController(rootViewController: StudentManagementViewController())
            student.tabBarItem = UITabBarItem(title: "StudentTabName".localized, image: UIImage(systemName: "graduationcap"), tag: 0)
                        
            let schedule = UINavigationController(rootViewController: ScheduleManagementViewController())
            schedule.tabBarItem = UITabBarItem(title: "일정관리".localized, image: UIImage(systemName: "star"), tag: 0)
            
            let setting = UINavigationController(rootViewController: UIViewController())
            setting.tabBarItem = UITabBarItem(title: "SettingTabName".localized, image: UIImage(systemName: "gearshape"), tag: 0)
            
             return [log, calendar, student, schedule, setting]
        }()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setConfigure()
        setConstraint()
    }
    
    func setConfigure() {
        view.addSubview(tabBar.view)
    }
    
    func setConstraint() {
        tabBar.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
