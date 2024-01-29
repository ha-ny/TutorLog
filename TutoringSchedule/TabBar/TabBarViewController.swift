//
//  TabBarViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = CalendarViewController()
        calendar.tabBarItem = UITabBarItem(title: "", image: .calender.withRenderingMode(.alwaysOriginal), selectedImage: .tapCalender.withRenderingMode(.alwaysOriginal))
        
        let student = UINavigationController(rootViewController: StudentManagementViewController())
        student.tabBarItem = UITabBarItem(title: "", image: .student.withRenderingMode(.alwaysOriginal), selectedImage: .tapStudent.withRenderingMode(.alwaysOriginal))
        
        let schedule = UINavigationController(rootViewController: ClassManagementViewController())
        schedule.tabBarItem = UITabBarItem(title: "", image: .classList.withRenderingMode(.alwaysOriginal), selectedImage: .tapClassList.withRenderingMode(.alwaysOriginal))
        
        tabBar.backgroundColor = .white
        
        viewControllers = [calendar, student, schedule]
    }
}
