//
//  UIAlertController+Extension.swift
//  TutoringSchedule
//
//  Created by 김하은 on 2023/10/22.
//

import UIKit

extension UIAlertController {
    static func customMessageAlert(view: UIViewController, title: String, message: String, _ completion: (() -> ())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "alertOKButtonTitle".localized, style: .default) { _ in
            completion?()
        }
        
        alert.addAction(ok)
        view.present(alert, animated: true)
    }
}
