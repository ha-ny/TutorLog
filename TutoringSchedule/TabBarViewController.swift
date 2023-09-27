//
//  TabBarViewController.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/09/27.
//

import UIKit
import SnapKit

class TabBarViewController: UIViewController {

    let tabBar = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        
        setConfigure()
        setConstraint()
        setController()
    }
    
    func setConfigure() {
        view.addSubview(tabBar.view)
    }
    
    func setConstraint() {
        tabBar.view.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setController() {
        let aa = UIViewController()
        aa.tabBarItem = UITabBarItem(title: "일지", image: UIImage(systemName: "book.closed"), tag: 0)
        
        let bb = UIViewController()
        bb.tabBarItem = UITabBarItem(title: "캘린더", image: UIImage(systemName: "calendar"), tag: 0)
        
        let cc = UIViewController()
        cc.tabBarItem = UITabBarItem(title: "학생", image: UIImage(systemName: "graduationcap"), tag: 0)
        
        let dd = UIViewController()
        dd.tabBarItem = UITabBarItem(title: "설정", image: UIImage(systemName: "gearshape"), tag: 0)
        
        tabBar.viewControllers = [aa, bb, cc, dd]
    }
}
