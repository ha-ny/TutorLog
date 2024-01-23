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
        view.tabBar.backgroundColor = .white
        view.viewControllers = {
            let calendar = CalendarViewController()
            calendar.tabBarItem = UITabBarItem(title: "", image: .calender.withRenderingMode(.alwaysOriginal), selectedImage: .tapCalender.withRenderingMode(.alwaysOriginal))

            let student = UINavigationController(rootViewController: StudentManagementViewController())
            student.tabBarItem = UITabBarItem(title: "", image: .list.withRenderingMode(.alwaysOriginal), selectedImage: .tapList.withRenderingMode(.alwaysOriginal))

             return [calendar, student]
        }()

        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgPrimary
//
//        let appearance = UITabBarAppearance()
//        appearance.configureWithDefaultBackground()
//        appearance.backgroundColor = .white
//
//        tabBar.tabBar.standardAppearance = appearance
//        tabBar.tabBar.scrollEdgeAppearance = appearance
//        
//        
        setConfigure()
        setConstraint()
    }
    
    func setConfigure() {
        view.addSubview(tabBar.view)
    }
    
    func setConstraint() {
        tabBar.view.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
