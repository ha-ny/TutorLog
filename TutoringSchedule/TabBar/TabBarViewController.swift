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
            
            let calendar = CalendarViewController()
            calendar.tabBarItem = UITabBarItem(title: "CalendarTabName".localized, image: UIImage(systemName: "calendar"), tag: 0)
    
            let student = UINavigationController(rootViewController: StudentManagementViewController())
            student.tabBarItem = UITabBarItem(title: "StudentTabName".localized, image: UIImage(systemName: "person.fill"), tag: 0)
                        
            let schedule = UINavigationController(rootViewController: ClassManagementViewController())
            schedule.tabBarItem = UITabBarItem(title: "ScheduleTabName".localized, image: UIImage(systemName: "note.text"), tag: 0)

            
             return [calendar, student, schedule]
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
